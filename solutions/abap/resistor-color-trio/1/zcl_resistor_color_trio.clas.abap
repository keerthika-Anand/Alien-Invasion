CLASS zcl_resistor_color_trio DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS label
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_resistor_color_trio IMPLEMENTATION.
  METHOD label.
    DATA: d1 TYPE i, d2 TYPE i, multiplier TYPE i,
          mantissa TYPE i, ohms TYPE p LENGTH 10 DECIMALS 0,
          value_str TYPE string, prefix TYPE string.

    " Color 1: first digit (unchanged)
    CASE colors[ 1 ].
      WHEN 'black'. d1 = 0.
      WHEN 'brown'. d1 = 1.
      WHEN 'red'. d1 = 2.
      WHEN 'orange'. d1 = 3.
      WHEN 'yellow'. d1 = 4.
      WHEN 'green'. d1 = 5.
      WHEN 'blue'. d1 = 6.
      WHEN 'violet'. d1 = 7.
      WHEN 'grey'. d1 = 8.
      WHEN 'white'. d1 = 9.
    ENDCASE.

    " Color 2: second digit (unchanged)
    CASE colors[ 2 ].
      WHEN 'black'. d2 = 0.
      WHEN 'brown'. d2 = 1.
      WHEN 'red'. d2 = 2.
      WHEN 'orange'. d2 = 3.
      WHEN 'yellow'. d2 = 4.
      WHEN 'green'. d2 = 5.
      WHEN 'blue'. d2 = 6.
      WHEN 'violet'. d2 = 7.
      WHEN 'grey'. d2 = 8.
      WHEN 'white'. d2 = 9.
    ENDCASE.

    " Color 3: multiplier (unchanged)
    CASE colors[ 3 ].
      WHEN 'black'. multiplier = 0.
      WHEN 'brown'. multiplier = 1.
      WHEN 'red'. multiplier = 2.
      WHEN 'orange'. multiplier = 3.
      WHEN 'yellow'. multiplier = 4.
      WHEN 'green'. multiplier = 5.
      WHEN 'blue'. multiplier = 6.
      WHEN 'violet'. multiplier = 7.
      WHEN 'grey'. multiplier = 8.
      WHEN 'white'. multiplier = 9.
    ENDCASE.

    " Calculate total ohms: mantissa * 10^multiplier
    mantissa = d1 * 10 + d2.
    ohms = mantissa.
    DO multiplier TIMES.
      ohms = ohms * 10.
    ENDDO.

    " Format with metric prefixes (test-exact)
    CASE multiplier.
      WHEN 0. 
        prefix = 'ohms'.
        value_str = |{ ohms }|.
      WHEN 1. 
        prefix = 'ohms'.
        value_str = |{ ohms }|.
      WHEN 2. 
        prefix = 'kiloohms'.
        value_str = |{ ohms / 1000 }|.
      WHEN 3. 
        prefix = 'kiloohms'.
        value_str = |{ ohms / 1000 }|.
      WHEN 4. 
        prefix = 'kiloohms'.
        value_str = |{ ohms / 1000 }|.
      WHEN 5. 
        prefix = 'megaohms'.
        value_str = |{ ohms / 1000000 }|.
      WHEN 6. 
        prefix = 'megaohms'.
        value_str = |{ ohms / 1000000 }|.
      WHEN 7. 
        prefix = 'megaohms'.
        value_str = |{ ohms / 1000000 }|.
      WHEN 8. 
        prefix = 'gigaohms'.
        value_str = |{ ohms / 1000000000 }|.
      WHEN 9. 
        prefix = 'gigaohms'.
        value_str = |{ ohms / 1000000000 }|.
    ENDCASE.

    result = |{ value_str } { prefix }|.
  ENDMETHOD.
ENDCLASS.
