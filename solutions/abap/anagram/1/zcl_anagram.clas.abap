CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_anagram IMPLEMENTATION.
  METHOD anagram.
    DATA: lv_target TYPE string,
          lv_cand TYPE string,
          lv_len TYPE i,
          lv_i TYPE i VALUE 0,
          lv_j TYPE i VALUE 0,
          lv_count_target TYPE i VALUE 0,
          lv_count_cand TYPE i VALUE 0,
          lv_char TYPE c LENGTH 1,
          lv_match TYPE abap_bool.

    lv_target = to_upper( input ).
    lv_len = strlen( lv_target ).

    LOOP AT candidates INTO lv_cand.
      " Quick rejects
      IF strlen( lv_cand ) <> lv_len OR to_upper( lv_cand ) = lv_target.
        CONTINUE.
      ENDIF.

      " Check character frequencies match
      lv_i = 0.
      WHILE lv_i < lv_len.
        lv_char = lv_target+lv_i(1).
        lv_count_target = 0.
        lv_count_cand = 0.
        
        " Count this char in target
        lv_j = 0.
        WHILE lv_j < lv_len.
          IF lv_target+lv_j(1) = lv_char.
            lv_count_target = lv_count_target + 1.
          ENDIF.
          lv_j = lv_j + 1.
        ENDWHILE.
        
        " Count this char in candidate  
        lv_j = 0.
        WHILE lv_j < lv_len.
          IF to_upper( lv_cand+lv_j(1) ) = lv_char.
            lv_count_cand = lv_count_cand + 1.
          ENDIF.
          lv_j = lv_j + 1.
        ENDWHILE.
        
        " Frequencies must match
        IF lv_count_target <> lv_count_cand.
          EXIT.
        ENDIF.
        lv_i = lv_i + 1.
      ENDWHILE.

      " All characters matched perfectly
      IF lv_i = lv_len.
        APPEND lv_cand TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
