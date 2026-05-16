package com.crichere.domain.fee.enums

enum class FeeType {
    PLAYER_FEE, FRANCHISE_FEE
}

enum class FeeStatus {
    UNPAID, PARTIALLY_PAID, PAID, WAIVED
}

enum class PaymentMode {
    CASH, ONLINE, REFUND, WAIVER
}
