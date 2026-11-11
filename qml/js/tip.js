.pragma library

/*
 * The tip arithmetic, in whole cents so that what is shown always adds up.
 *
 * Version 0.2 rounded the tip and the total separately, from floating point values:
 * 1.25 with an 18 % tip showed a tip of 0.22 and a total of 1.48.
 */

// What the bill field accepts: up to nine digits, then "." or "," and up to two decimals.
// The old pattern was [\.|,], a character class that also accepted a literal pipe.
var AMOUNT_PATTERN = /^\d{1,9}([.,]\d{0,2})?$/;

/*
 * The amount typed in the bill field, in cents, or -1 when there is none yet.
 *
 * Read from the digits rather than with Number.fromLocaleString: in an English locale
 * that takes "1,50" for one hundred and fifty, while here a comma is always the
 * decimal separator.
 */
function parseCents(text) {
    var match = AMOUNT_PATTERN.exec(text ? String(text).trim() : "");
    if (!match) {
        return -1;
    }
    var parts = String(text).trim().split(/[.,]/);
    var whole = parseInt(parts[0], 10);
    var fraction = parts.length > 1 ? (parts[1] + "00").substring(0, 2) : "00";
    return whole * 100 + parseInt(fraction, 10);
}

// {bill, tip, total} in cents for a bill in cents and a whole percentage.
function compute(billCents, percent) {
    if (billCents < 0) {
        return null;
    }
    var tip = Math.round(billCents * percent / 100);
    return { bill: billCents, tip: tip, total: billCents + tip };
}

// vim:et:ts=4:sw=4
