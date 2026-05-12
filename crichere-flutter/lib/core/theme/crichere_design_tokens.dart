// ============================================================
// CRICHERE — Design Tokens for Flutter
// Generated from HTML Prototype (S1–S11)
// Use this file as the single source of truth for all
// colors, typography, spacing, and border-radius values.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── COLOR PALETTE ────────────────────────────────────────────

class CricColor {
  CricColor._();

  // Background layers (darkest → lighter)
  static const Color appBg       = Color(0xFF060C1A); // outermost background
  static const Color navy        = Color(0xFF0A0F1E); // primary card/screen bg
  static const Color navyMid     = Color(0xFF0F172A); // secondary surfaces
  static const Color slate       = Color(0xFF1A2236); // elevated surface
  static const Color slate2      = Color(0xFF1E293B); // card background
  static const Color slate3      = Color(0xFF243047); // tab bar / input bg
  static const Color slate4      = Color(0xFF2D3A52); // border color (solid)

  // Borders (with opacity)
  static const Color borderLight = Color(0x1A94A3B8); // rgba(148,163,184, 0.10)
  static const Color borderMid   = Color(0x2E94A3B8); // rgba(148,163,184, 0.18)

  // Accent / Semantic colors
  static const Color gold        = Color(0xFFF59E0B); // primary CTA, league/T20 badge
  static const Color goldLight   = Color(0xFFFCD34D); // highlight / glow
  static const Color green       = Color(0xFF22C55E); // success, sold, active
  static const Color red         = Color(0xFFEF4444); // live, error, danger
  static const Color blue        = Color(0xFF3B82F6); // upcoming, info
  static const Color purple      = Color(0xFFA855F7); // special badges
  static const Color cyan        = Color(0xFF06B6D4); // highlights

  // Text hierarchy
  static const Color textPrimary  = Color(0xFFF1F5F9); // --tx  : main labels
  static const Color textMid      = Color(0xFFCBD5E1); // --txm : secondary text
  static const Color textDim      = Color(0xFF94A3B8); // --txd : dimmed / meta
  static const Color textFaint    = Color(0xFF64748B); // --txf : placeholders, captions

  // Badge background shortcuts
  static Color badgeBg(Color accent) => accent.withValues(alpha: 0.15);
}

// ─── TYPOGRAPHY ───────────────────────────────────────────────
// Fonts used in prototype:
//   Display / Logo  →  Rajdhani (weights 600, 700)
//   Body / UI       →  DM Sans  (weights 300–700, opticalSize 9–40)
//   Mono / code     →  JetBrains Mono (weights 500, 700)
//
// Add these to pubspec.yaml → fonts (or use google_fonts package):
//   google_fonts: ^6.x
//   Then replace TextStyle with GoogleFonts.rajdhani(...) etc.

class CricTextStyle {
  CricTextStyle._();

  // Logo / App name
  static final TextStyle logo = GoogleFonts.rajdhani(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: CricColor.gold,
    letterSpacing: 1.0,
  );

  // Large display heading (auction player name, big numbers)
  static final TextStyle displayLg = GoogleFonts.rajdhani(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: CricColor.textPrimary,
    letterSpacing: 0.5,
  );

  // Section heading inside screens
  static final TextStyle headingMd = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: CricColor.textPrimary,
  );

  // Body text
  static final TextStyle body = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: CricColor.textMid,
  );

  // Small label / caption
  static final TextStyle caption = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: CricColor.textDim,
  );

  // Overline / eyebrow label (all caps)
  static final TextStyle overline = GoogleFonts.rajdhani(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: CricColor.textFaint,
    letterSpacing: 1.0,
  );

  // Pill / badge text
  static final TextStyle badge = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  // Monospace (API routes, version strings, keyboard shortcuts)
  static final TextStyle mono = GoogleFonts.jetBrainsMono(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: CricColor.textDim,
  );

  // Large bid/price number
  static final TextStyle bidNumber = GoogleFonts.rajdhani(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: CricColor.gold,
  );

  // Timer number
  static final TextStyle timerNumber = GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: CricColor.textPrimary,
  );
}

// ─── SPACING ──────────────────────────────────────────────────

class CricSpacing {
  CricSpacing._();

  static const double xs   = 4.0;
  static const double sm   = 8.0;
  static const double md   = 12.0;
  static const double base = 16.0;
  static const double lg   = 20.0;
  static const double xl   = 24.0;
  static const double xxl  = 32.0;
  static const double page = 24.0; // horizontal screen padding
}

// ─── BORDER RADIUS ────────────────────────────────────────────

class CricRadius {
  CricRadius._();

  static const double chip     = 20.0; // pills / nav-chips
  static const double card     = 12.0; // content cards
  static const double input    = 8.0;  // text fields
  static const double button   = 8.0;  // buttons
  static const double phone    = 44.0; // phone frame (prototype only)
  static const double avatar   = 999.0; // circular avatar
  static const double badge    = 4.0;  // small square badge

  static const BorderRadius chipAll  = BorderRadius.all(Radius.circular(chip));
  static const BorderRadius cardAll  = BorderRadius.all(Radius.circular(card));
  static const BorderRadius inputAll = BorderRadius.all(Radius.circular(input));
  static const BorderRadius btnAll   = BorderRadius.all(Radius.circular(button));
}

// ─── SHARED DECORATIONS ───────────────────────────────────────

class CricDecoration {
  CricDecoration._();

  static const BoxDecoration card = BoxDecoration(
    color: CricColor.slate2,
    borderRadius: CricRadius.cardAll,
    border: Border.fromBorderSide(BorderSide(color: CricColor.borderMid, width: 1)),
  );

  static final BoxDecoration stickyNavBar = BoxDecoration(
    color: CricColor.appBg.withValues(alpha: 0.95),
    border: const Border(
      bottom: BorderSide(color: CricColor.borderLight, width: 1),
    ),
  );

  static InputDecoration textField({String? hint, Widget? prefix}) =>
      InputDecoration(
        hintText: hint,
        hintStyle: CricTextStyle.body.copyWith(color: CricColor.textFaint),
        prefixIcon: prefix,
        filled: true,
        fillColor: CricColor.slate3,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: CricSpacing.base, vertical: CricSpacing.md),
        border: OutlineInputBorder(
          borderRadius: CricRadius.inputAll,
          borderSide: BorderSide(color: CricColor.borderMid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: CricRadius.inputAll,
          borderSide: BorderSide(color: CricColor.borderMid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: CricRadius.inputAll,
          borderSide: const BorderSide(color: CricColor.gold, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: CricRadius.inputAll,
          borderSide: const BorderSide(color: CricColor.red),
        ),
      );
}

// ─── BUTTON STYLES ────────────────────────────────────────────

class CricButtonStyle {
  CricButtonStyle._();

  // Primary gold CTA (e.g. "GET STARTED", "Send OTP", "Place Bid")
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: CricColor.gold,
    foregroundColor: const Color(0xFF1A0F00),
    textStyle: CricTextStyle.badge.copyWith(
        fontSize: 14, fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(borderRadius: CricRadius.btnAll),
    padding: const EdgeInsets.symmetric(
        horizontal: CricSpacing.xl, vertical: CricSpacing.md),
    elevation: 0,
  );

  // Success green (e.g. "Save", "Confirm")
  static final ButtonStyle success = ElevatedButton.styleFrom(
    backgroundColor: CricColor.green,
    foregroundColor: Colors.white,
    textStyle: CricTextStyle.badge.copyWith(
        fontSize: 14, fontWeight: FontWeight.w700),
    shape: RoundedRectangleBorder(borderRadius: CricRadius.btnAll),
    padding: const EdgeInsets.symmetric(
        horizontal: CricSpacing.xl, vertical: CricSpacing.md),
    elevation: 0,
  );

  // Ghost / outline
  static final ButtonStyle ghost = OutlinedButton.styleFrom(
    foregroundColor: CricColor.textMid,
    side: const BorderSide(color: CricColor.borderMid),
    textStyle: CricTextStyle.badge,
    shape: RoundedRectangleBorder(borderRadius: CricRadius.btnAll),
    padding: const EdgeInsets.symmetric(
        horizontal: CricSpacing.lg, vertical: CricSpacing.sm),
  );
}

// ─── THEME ────────────────────────────────────────────────────

ThemeData cricTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CricColor.appBg,
    colorScheme: const ColorScheme.dark(
      primary:   CricColor.gold,
      secondary: CricColor.green,
      error:     CricColor.red,
      surface:   CricColor.slate2,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: CricColor.navyMid,
      foregroundColor: CricColor.textPrimary,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: CricColor.slate2,
      shape: RoundedRectangleBorder(
        borderRadius: CricRadius.cardAll,
        side: const BorderSide(color: CricColor.borderMid, width: 1),
      ),
      margin: EdgeInsets.zero,
      elevation: 0,
    ),
    textTheme: TextTheme(
      displayLarge:  CricTextStyle.displayLg,
      titleMedium:   CricTextStyle.headingMd,
      bodyMedium:    CricTextStyle.body,
      bodySmall:     CricTextStyle.caption,
      labelSmall:    CricTextStyle.overline,
    ),
    fontFamily: 'DM Sans',
  );
}
