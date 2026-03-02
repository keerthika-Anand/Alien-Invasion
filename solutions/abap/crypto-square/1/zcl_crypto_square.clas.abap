CLASS zcl_crypto_square DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS encode IMPORTING plain_text         TYPE string
                   RETURNING VALUE(crypto_text) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_crypto_square IMPLEMENTATION.
  METHOD encode.
    data: p type string,
s type string,
c.
    p = plain_text.
    p = to_lower( p ).
    condense p no-gaps.
data(n) = strlen( p ).
do n times.
data(off) = sy-index - 1.
c = p+off(1).
if c co to_lower( sy-abcde ) or c co '0123456789'.
concatenate s c into s.
endif.
enddo.

n = strlen( s ).
if n gt 1.
    data: r1 type i.
    r1 = floor( sqrt( n ) ).
    if ( r1 * r1 ) ge n.
        data(c1) = r1.
    elseif ( r1 * ( r1 + 1 ) ) ge n.
        c1 = r1 + 1.
    elseif ( ( r1 + 1 ) ** 2 ) ge n.
        c1 = r1 + 1.
        r1 = r1 + 1.
    endif.


data: t type table of string,
s1 type string,
st type i value 0.

 DO r1 TIMES.       off = st.       DO c1 TIMES.         IF off + 1 LE n.           CONCATENATE s1 s+off(1) INTO s1.         ELSE.           CONCATENATE s1 ` ` INTO s1.         ENDIF.         off = off + c1.       ENDDO.       APPEND s1 TO t.       CLEAR: s1.       st = st + 1.       IF st EQ 7.         off = st.         DO c1 TIMES.           IF off + 1 LE n.             CONCATENATE s1 s+off(1) INTO s1.           ELSE.             CONCATENATE s1 ` ` INTO s1.           ENDIF.           off = off + c1.         ENDDO.         APPEND s1 TO t.       ENDIF.     ENDDO.

loop at t into data(w).

condense w.
if strlen( w ) lt r1. 
concatenate w ` ` into w.
endif.

concatenate crypto_text w into crypto_text.
if not lines( t ) eq sy-tabix.
  concatenate crypto_text ` ` into crypto_text.
endif.

endloop.

else.
crypto_text = s.
endif.


   
  ENDMETHOD.
ENDCLASS.













