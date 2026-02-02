CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    DATA : lv_len TYPE i,
           lv_off TYPE i VALUE 0,
           lv_char TYPE c LENGTH 1,
           lv_upper TYPE c LENGTH 1,
           lv_total TYPE i VALUE 0.

    lv_len = strlen( input ).

    WHILE lv_off < lv_len.
      lv_char = input+lv_off(1).
      lv_upper = to_upper( lv_char ).

      CASE lv_upper.
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
          lv_total =  lv_total + 1.
        WHEN 'D' OR 'G'.
          lv_total =  lv_total + 2.
        WHEN 'B' OR 'C' OR 'M' OR 'P'.
          lv_total =  lv_total + 3.
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
          lv_total = lv_total + 4.
        WHEN 'K'.
          lv_total = lv_total + 5.
        WHEN 'J' OR 'X'.
          lv_total = lv_total + 8.
        WHEN 'Q' OR 'Z'.
          lv_total = lv_total + 10.
      ENDCASE.
      lv_off = lv_off + 1.
    ENDWHILE.
    result = lv_total.

  ENDMETHOD.

ENDCLASS.
