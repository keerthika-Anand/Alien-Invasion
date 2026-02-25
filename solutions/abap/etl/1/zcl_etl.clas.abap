CLASS zcl_etl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_legacy_data,
        number TYPE i,
        string TYPE string,
      END OF ty_legacy_data,
      BEGIN OF ty_new_data,
        letter TYPE c LENGTH 1,
        number TYPE i,
      END OF ty_new_data,
      tty_legacy_data TYPE SORTED TABLE OF ty_legacy_data WITH UNIQUE KEY number,
      tty_new_data    TYPE SORTED TABLE OF ty_new_data WITH UNIQUE KEY letter.

    METHODS transform IMPORTING legacy_data     TYPE tty_legacy_data
                      RETURNING VALUE(new_data) TYPE tty_new_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_etl IMPLEMENTATION.
  METHOD transform.
    DATA: ls_new TYPE ty_new_data,
          ls_legacy TYPE ty_legacy_data,
          lv_char TYPE c LENGTH 1,
          lv_pos TYPE i.

    LOOP AT legacy_data INTO ls_legacy.
      lv_pos = 0.
      WHILE lv_pos < strlen( ls_legacy-string ).
        lv_char = ls_legacy-string+lv_pos(1).
        " Only process letters (skip spaces, numbers, etc.)
        IF lv_char CA 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
          CLEAR ls_new.
          ls_new-letter = to_lower( lv_char ).
          ls_new-number = ls_legacy-number.
          INSERT ls_new INTO TABLE new_data.
        ENDIF.
        lv_pos = lv_pos + 1.
      ENDWHILE.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
