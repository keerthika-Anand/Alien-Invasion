CLASS zcl_armstrong_numbers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS is_armstrong_number IMPORTING num           TYPE i
                                RETURNING VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_armstrong_numbers IMPLEMENTATION.
  METHOD is_armstrong_number.
    DATA: lv_temp      TYPE i,
          lv_original  TYPE i,
          lv_digit     TYPE i,
          lv_power     TYPE i,
          lv_sum       TYPE i,
          lv_num_str   TYPE string,
          lv_count     TYPE i.
    
    lv_original = num.
    lv_temp = num.
    
    " Count digits
    lv_num_str = lv_temp.
    CONDENSE lv_num_str NO-GAPS.
    lv_count = strlen( lv_num_str ).
    
    " Calculate power for each digit
    lv_power = 1.
    DO lv_count TIMES.
      lv_power = lv_power * lv_count.
    ENDDO.
    
    " Extract digits and calculate sum
    lv_temp = num.
    WHILE lv_temp > 0.
      lv_digit = lv_temp MOD 10.
      lv_sum = lv_sum + lv_digit ** lv_count.
      lv_temp = lv_temp DIV 10.
    ENDWHILE.
    
    " Check if sum equals original number
    IF lv_sum = lv_original.
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
