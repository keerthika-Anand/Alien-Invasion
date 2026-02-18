CLASS zcl_raindrops DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS raindrops
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_raindrops IMPLEMENTATION.

  METHOD raindrops.
    DATA: lv_result TYPE string VALUE ``.

    IF input MOD 3 = 0.
      lv_result = |{ lv_result }Pling|.
    ENDIF.

    IF input MOD 5 = 0.
      lv_result = |{ lv_result }Plang|.
    ENDIF.

    IF input MOD 7 = 0.
      lv_result = |{ lv_result }Plong|.
    ENDIF.

    IF lv_result IS INITIAL.
      lv_result = |{ input }|.
    ENDIF.

    result = lv_result.
  ENDMETHOD.

ENDCLASS.

