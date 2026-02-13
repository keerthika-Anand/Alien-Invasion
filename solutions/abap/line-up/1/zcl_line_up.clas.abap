CLASS zcl_line_up DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS format IMPORTING name          TYPE string
                             number        TYPE i
                   RETURNING VALUE(result) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_line_up IMPLEMENTATION.
  METHOD format.
    DATA: lv_num_str TYPE string,
          lv_suffix  TYPE string.

    lv_num_str = |{ number }|.

    lv_suffix = COND #( 
      WHEN number MOD 100 = 11 OR number MOD 100 = 12 OR number MOD 100 = 13 THEN 'th'
      WHEN number MOD 10 = 1 THEN 'st'
      WHEN number MOD 10 = 2 THEN 'nd'
      WHEN number MOD 10 = 3 THEN 'rd'
      ELSE 'th' ).

    result = |{ name }, you are the { lv_num_str }{ lv_suffix } customer we serve today. Thank you!|.
  ENDMETHOD.
ENDCLASS.
