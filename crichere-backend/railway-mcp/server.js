#!/usr/bin/env node

const { Server } = require("@modelcontextprotocol/sdk/server/index.js");
const { StdioServerTransport } = require("@modelcontextprotocol/sdk/server/stdio.js");
const { CallToolRequestSchema, ListToolsRequestSchema } = require("@modelcontextprotocol/sdk/types.js");
const axios = require("axios");

const RAILWAY_API = "https://api.railway.app/graphql";
const RAILWAY_TOKEN = process.env.RAILWAY_TOKEN;

if (!RAILWAY_TOKEN) {
  console.error("RAILWAY_TOKEN environment variable not set");
  process.exit(1);
}

const server = new Server({
  name: "railway-mcp",
  version: "1.0.0",
});

const tools = [
  {
    name: "get_deployment_logs",
    description: "Get deployment logs for a service to diagnose issues",
    inputSchema: {
      type: "object",
      properties: {
        serviceId: { type: "string", description: "Service ID" },
        deploymentId: { type: "string", description: "Deployment ID" },
        filter: { type: "string", description: "Filter logs (e.g., 'error', 'localhost')" },
        limit: { type: "number", description: "Number of logs to fetch (default: 50)" }
      },
      required: ["serviceId", "deploymentId"]
    }
  },
  {
    name: "get_service_config",
    description: "Get current service configuration including variables",
    inputSchema: {
      type: "object",
      properties: {
        serviceId: { type: "string", description: "Service ID" }
      },
      required: ["serviceId"]
    }
  },
  {
    name: "update_service_variables",
    description: "Update service environment variables",
    inputSchema: {
      type: "object",
      properties: {
        serviceId: { type: "string", description: "Service ID" },
        variables: { 
          type: "object", 
          description: "Variables to set (key-value pairs)",
          additionalProperties: { type: "string" }
        }
      },
      required: ["serviceId", "variables"]
    }
  },
  {
    name: "deploy_service",
    description: "Trigger a new deployment for a service",
    inputSchema: {
      type: "object",
      properties: {
        serviceId: { type: "string", description: "Service ID" }
      },
      required: ["serviceId"]
    }
  },
  {
    name: "get_service_status",
    description: "Get current deployment status of a service",
    inputSchema: {
      type: "object",
      properties: {
        serviceId: { type: "string", description: "Service ID" }
      },
      required: ["serviceId"]
    }
  },
  {
    name: "list_deployments",
    description: "List recent deployments for a service",
    inputSchema: {
      type: "object",
      properties: {
        serviceId: { type: "string", description: "Service ID" },
        limit: { type: "number", description: "Number of deployments to list (default: 5)" }
      },
      required: ["serviceId"]
    }
  }
];

server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: tools
}));

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const { name, arguments: args } = request;

  try {
    switch (name) {
      case "get_deployment_logs": {
        const query = `
          query {
            deployment(id: "${args.deploymentId}") {
              logs(limit: ${args.limit || 50}) {
                message
                timestamp
                severity
              }
            }
          }
        `;
        const response = await axios.post(RAILWAY_API, { query }, {
          headers: { Authorization: `Bearer ${RAILWAY_TOKEN}` }
        });
        const logs = response.data?.data?.deployment?.logs || [];
        const filtered = args.filter 
          ? logs.filter(l => l.message.toLowerCase().includes(args.filter.toLowerCase()))
          : logs;
        return { 
          content: [{ 
            type: "text", 
            text: JSON.stringify(filtered, null, 2) 
          }] 
        };
      }

      case "get_service_config": {
        const query = `
          query {
            service(id: "${args.serviceId}") {
              name
              source {
                repo
                branch
              }
              variables {
                name
                value
              }
              deploy {
                startCommand
                healthcheckPath
              }
            }
          }
        `;
        const response = await axios.post(RAILWAY_API, { query }, {
          headers: { Authorization: `Bearer ${RAILWAY_TOKEN}` }
        });
        return { 
          content: [{ 
            type: "text", 
            text: JSON.stringify(response.data?.data?.service, null, 2) 
          }] 
        };
      }

      case "update_service_variables": {
        const variables = Object.entries(args.variables).map(([name, value]) => ({
          name,
          value
        }));
        const mutation = `
          mutation {
            updateService(id: "${args.serviceId}", variables: ${JSON.stringify(variables)}) {
              success
              message
            }
          }
        `;
        const response = await axios.post(RAILWAY_API, { mutation }, {
          headers: { Authorization: `Bearer ${RAILWAY_TOKEN}` }
        });
        return { 
          content: [{ 
            type: "text", 
            text: JSON.stringify(response.data?.data?.updateService, null, 2) 
          }] 
        };
      }

      case "deploy_service": {
        const mutation = `
          mutation {
            deploy(serviceId: "${args.serviceId}") {
              deploymentId
              status
            }
          }
        `;
        const response = await axios.post(RAILWAY_API, { mutation }, {
          headers: { Authorization: `Bearer ${RAILWAY_TOKEN}` }
        });
        return { 
          content: [{ 
            type: "text", 
            text: JSON.stringify(response.data?.data?.deploy, null, 2) 
          }] 
        };
      }

      case "get_service_status": {
        const query = `
          query {
            service(id: "${args.serviceId}") {
              name
              activeDeployment {
                id
                status
                createdAt
              }
              recentFailures
            }
          }
        `;
        const response = await axios.post(RAILWAY_API, { query }, {
          headers: { Authorization: `Bearer ${RAILWAY_TOKEN}` }
        });
        return { 
          content: [{ 
            type: "text", 
            text: JSON.stringify(response.data?.data?.service, null, 2) 
          }] 
        };
      }

      case "list_deployments": {
        const query = `
          query {
            service(id: "${args.serviceId}") {
              deployments(limit: ${args.limit || 5}) {
                id
                status
                createdAt
                commitHash
                commitMessage
              }
            }
          }
        `;
        const response = await axios.post(RAILWAY_API, { query }, {
          headers: { Authorization: `Bearer ${RAILWAY_TOKEN}` }
        });
        return { 
          content: [{ 
            type: "text", 
            text: JSON.stringify(response.data?.data?.service?.deployments, null, 2) 
          }] 
        };
      }

      default:
        return { content: [{ type: "text", text: `Unknown tool: ${name}` }] };
    }
  } catch (error) {
    return { 
      content: [{ 
        type: "text", 
        text: `Error: ${error.message}\n${error.response?.data ? JSON.stringify(error.response.data) : ''}` 
      }] 
    };
  }
});

const transport = new StdioServerTransport();
server.connect(transport);
