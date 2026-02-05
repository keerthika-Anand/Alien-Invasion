CLASS zcl_reverse_string DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS reverse_string
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_reverse_string IMPLEMENTATION.

  METHOD reverse_string.
    DATA: lv_len  TYPE i,
          lv_rev  TYPE string,
          lv_char TYPE string, 
          lv_i    TYPE i.
    
    lv_len = strlen( input ).
    lv_rev = ''.
    
    DO lv_len TIMES.
      lv_i = lv_len - sy-index.
      lv_char = input+lv_i(1).
      lv_rev = lv_rev && lv_char.
    ENDDO.
    
    result = lv_rev.
  ENDMETHOD.

ENDCLASS.

