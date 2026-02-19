CLASS zcl_eliuds_eggs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS egg_count IMPORTING number       TYPE i
                      RETURNING VALUE(count) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_eliuds_eggs IMPLEMENTATION.
  METHOD egg_count.
    DATA: lv_num TYPE i,
          lv_rem TYPE i,
          lv_count TYPE i VALUE 0.

    lv_num = number.
    
    WHILE lv_num > 0.
      lv_rem = lv_num MOD 2.
      IF lv_rem = 1.
        lv_count = lv_count + 1.
      ENDIF.
      lv_num = lv_num DIV 2.
    ENDWHILE.
    
    count = lv_count.
  ENDMETHOD.
ENDCLASS.
