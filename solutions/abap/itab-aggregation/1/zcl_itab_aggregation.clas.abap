CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
  DATA: lt_groups TYPE TABLE OF group,
        ls_agg    TYPE aggregated_data_type,
        lv_count  TYPE i,
        lv_sum    TYPE i,
        lv_min    TYPE i,
        lv_max    TYPE i,
        lv_group  TYPE group,
        ls_number TYPE initial_numbers_type,
        lv_average TYPE f.

  " Get unique groups
  LOOP AT initial_numbers INTO DATA(ls_input).
    APPEND ls_input-group TO lt_groups.
  ENDLOOP.
  SORT lt_groups.
  DELETE ADJACENT DUPLICATES FROM lt_groups.
  
  " Aggregate each group
  LOOP AT lt_groups INTO lv_group.
    CLEAR: lv_count, lv_sum, lv_min, lv_max.
    lv_min = 999999.
    
    LOOP AT initial_numbers INTO ls_number WHERE group = lv_group.
      lv_count = lv_count + 1.
      lv_sum = lv_sum + ls_number-number.
      IF ls_number-number < lv_min.
        lv_min = ls_number-number.
      ENDIF.
      IF ls_number-number > lv_max.
        lv_max = ls_number-number.
      ENDIF.
    ENDLOOP.
    
    CLEAR ls_agg.
    ls_agg-group = lv_group.
    ls_agg-count = lv_count.
    ls_agg-sum = lv_sum.
    ls_agg-min = lv_min.
    ls_agg-max = lv_max.
    
    " Fix: Proper IF syntax for average
    IF lv_count > 0.
      lv_average = lv_sum / lv_count.
    ELSE.
      lv_average = 0.
    ENDIF.
    ls_agg-average = lv_average.
    
    APPEND ls_agg TO aggregated_data.
  ENDLOOP.
  ENDMETHOD.
ENDCLASS.
