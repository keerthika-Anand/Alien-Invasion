CLASS zcl_resistor_color_duo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS value
      IMPORTING
        colors       TYPE string_table
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_resistor_color_duo IMPLEMENTATION.
  METHOD value.
    DATA: digit1 TYPE i,
          digit2 TYPE i.

    " Decode first color (tens digit)
    CASE colors[ 1 ].
      WHEN 'black'.   digit1 = 0.
      WHEN 'brown'.   digit1 = 1.
      WHEN 'red'.     digit1 = 2.
      WHEN 'orange'.  digit1 = 3.
      WHEN 'yellow'.  digit1 = 4.
      WHEN 'green'.   digit1 = 5.
      WHEN 'blue'.    digit1 = 6.
      WHEN 'violet'.  digit1 = 7.
      WHEN 'grey'.    digit1 = 8.
      WHEN 'white'.   digit1 = 9.
    ENDCASE.

    " Decode second color (units digit)  
    CASE colors[ 2 ].
      WHEN 'black'.   digit2 = 0.
      WHEN 'brown'.   digit2 = 1.
      WHEN 'red'.     digit2 = 2.
      WHEN 'orange'.  digit2 = 3.
      WHEN 'yellow'.  digit2 = 4.
      WHEN 'green'.   digit2 = 5.
      WHEN 'blue'.    digit2 = 6.
      WHEN 'violet'.  digit2 = 7.
      WHEN 'grey'.    digit2 = 8.
      WHEN 'white'.   digit2 = 9.
    ENDCASE.

    " Combine: first color * 10 + second color (10-99 range)
    result = digit1 * 10 + digit2.
  ENDMETHOD.
ENDCLASS.

