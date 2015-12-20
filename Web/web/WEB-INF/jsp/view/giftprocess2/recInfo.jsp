{
    "id": "${rec.id}",
    "firstName": "${rec.firstName}",
    "middleName":"${rec.middleName}",
    "lastName":"${rec.lastName}",
    "email":"${rec.email}",
    "dialCode": "${rec.dialCode}",
    "phone": "${rec.phone}",
    "note": "<c:out value="${rec.note}" escapeXml="true" default="Happy Birthday"/>"
}