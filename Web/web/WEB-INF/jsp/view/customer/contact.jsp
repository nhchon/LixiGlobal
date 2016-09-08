<template:Client htmlTitle="Lixi Global - Customer Service">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
            $(document).ready(function () {
                $('#captchaImg').on({
                    'click': function () {
                        $('#captchaImg').attr('src', CONTEXT_PATH + '/captcha?time=' + (new Date()).getTime());
                    }
                });
            });
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="main-section contact-section">
            <div class="contact-section-top text-center text-white">
                <div class="container">
                    <%-- text-align:justify;text-justify:inter-word;text-align-last:center;-ms-text-align-last:center;-moz-text-align-last: center;--%>
                    <div class="contact-section-top-content" style="text-align: left;">
                        <h1 class="text-uppercase" style="text-align: center;"><span><spring:message code="what-is-lixi"/></span></h1>
                        <div>
                            <c:import url="/whatIsLixi"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="map-section-content">
                <div class="row">

                    <div class="col-md-7">
                        <div class="map-wrapper position-relative">
                            <input id="pac-input" value="3329 W Apollo Rd Phoenix,AZ 85041" class="controls" type="text" placeholder="Search Box">
                            <div id="google-map"></div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-contact-wrapper">
                            <div style="padding-bottom:20px;">
                                <h4 class="title text-uppercase"><spring:message code="cont-info"/></h4>
                                <p>
                                    <spring:message code="feel-free"/>
                                </p>
                                <div>
                                    3329 W. Apollo Rd
                                    <br/>
                                    Phoenix, AZ 85041
                                    <br/>
                                    <p>
                                        <a href="<c:url value="/support/terms"/>">Terms of Use</a>&nbsp;|&nbsp;<a href="<c:url value="/support/refundPolicy"/>">Privacy Policy</a>
                                    </p>
                                </div>
                            </div>
                            <c:if test="${validationErrors != null}"><div class="msg msg-error">
                            <ul>
                                <c:forEach items="${validationErrors}" var="error">
                                    <li><c:out value="${error.message}" /></li>
                                    </c:forEach>
                            </ul>
                            </div></c:if>
                            <form:form method="post" class="contact-form" modelAttribute="lixiContactForm">
                                <c:if test="${secCodeWrong eq '1'}">
                                    <div class="alert alert-danger" role="alert">
                                        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                                        <span class="sr-only">Error:</span>
                                        <spring:message code="sec-code-wrong"/>
                                    </div>
                                </c:if>
                                <div class="form-group">
                                    <label><spring:message code="message.name"/></label>
                                    <form:input path="name" placeholder="Name" class="form-control"/>
                                    <div class="has-error"><form:errors path="name" cssClass="help-block" element="div"/></div>
                                </div>
                                <div class="form-group">
                                    <label><spring:message code="message.mobile_number"/></label>
                                    <form:input path="phone" placeholder="Mobile phone" class="form-control"/>
                                    <div class="has-error"><form:errors path="phone" cssClass="help-block" element="div"/></div>
                                </div>
                                <div class="form-group">
                                    <label><spring:message code="message.email"/></label>
                                    <form:input path="email" placeholder="Email" class="form-control"/>
                                    <div class="has-error"><form:errors path="email" cssClass="help-block" element="div"/></div>
                                </div>
                                <div class="form-group">
                                    <label><spring:message code="mess.mess"/></label>
                                    <form:textarea path="message" placeholder="Message" class="form-control"></form:textarea>
                                    <div class="has-error"><form:errors path="message" cssClass="help-block" element="div"/></div>
                                </div>
                                <div class="form-group">
                                    <label><spring:message code="sec-code" text="Security code"/>:&nbsp;</label>
                                    <img style="cursor: pointer;margin-bottom: 5px;" title="Click to Reload Image" id="captchaImg" alt="Captcha" src="<c:url value="/captcha"/>" />
                                    <form:input path="secCode" placeholder="Security code" class="form-control"/>
                                    <div class="has-error"><form:errors path="secCode" cssClass="help-block" element="div"/></div>
                                </div>
                                <div class="button-control">
                                    <button type="submit" class="btn btn-primary text-uppercase">SEND</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places" type="text/javascript"></script>
        <script>
            function initAutocomplete() {
                $('#google-map').css({
                    height: $('.form-contact-wrapper').height()
                });
                var lat = 33.852681;
                var lng = -112.130629;
                var map = new google.maps.Map(document.getElementById('google-map'), {
                    center: {lat: lat, lng: lng},
                    zoom: 13,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });

                // Create the search box and link it to the UI element.
                var input = document.getElementById('pac-input');
                var searchBox = new google.maps.places.SearchBox(input);
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

                // Bias the SearchBox results towards current map's viewport.
                map.addListener('bounds_changed', function () {
                    searchBox.setBounds(map.getBounds());
                });

                var markers = [];
                // Listen for the event fired when the user selects a prediction and retrieve
                // more details for that place.
                searchBox.addListener('places_changed', function () {
                    var places = searchBox.getPlaces();

                    if (places.length === 0) {
                        return;
                    }

                    // Clear out the old markers.
                    markers.forEach(function (marker) {
                        marker.setMap(null);
                    });
                    markers = [];

                    // For each place, get the icon, name and location.
                    var bounds = new google.maps.LatLngBounds();
                    places.forEach(function (place) {
                        var icon = {
                            url: place.icon,
                            size: new google.maps.Size(71, 71),
                            origin: new google.maps.Point(0, 0),
                            anchor: new google.maps.Point(17, 34),
                            scaledSize: new google.maps.Size(25, 25)
                        };

                        // Create a marker for each place.
                        markers.push(new google.maps.Marker({
                            map: map,
                            icon: icon,
                            title: place.name,
                            position: place.geometry.location
                        }));

                        if (place.geometry.viewport) {
                            // Only geocodes have viewport.
                            bounds.union(place.geometry.viewport);
                        } else {
                            bounds.extend(place.geometry.location);
                        }
                    });
                    map.fitBounds(bounds);
                });
                var myLatLng = new google.maps.LatLng(lat, lng);
                var marker = new google.maps.Marker({
                    position: myLatLng,
                    map: map,
                    title: 'LIXI.GLOBAL'
                });
                var title_site = 'LIXI.GLOBAL';
                //var phone_site = 'US+1 123456';
                var email_to = '<a style="color:green;" href="mailto:contact@lixi.global">contact@lixi.global</a>';
                var address_to = '3329 W Apollo Rd, Phoenix AZ 85041';
                var infowindow = new google.maps.InfoWindow({
                    content: "<div style='text-align: left; color:black;'><div  style=\"color: black; font-weight: bold; font-family: Arial; font-size: 0.9em\">" + title_site + "</div><div style=\"font-family: Arial; font-size: 0.9em; color:black;\">Email: " + email_to + "</div><div style='clear:both;'></div><div style=\"font-family: Arial; font-size: 0.9em\">Address: " + address_to + "</div></div><div style='clear:both;'></div><div style=\"font-family: Arial; font-size: 0.9em; color:black;\">Website: <a style='color:green;' href='" + siteUrl + "'>" + siteUrl + "</a></div>",
                    maxWidth: 625,
                    boxStyle: {
                        border: "1px solid black"
                    },
                    position: myLatLng,
                    pixelOffset: new google.maps.Size(-1, 0)
                });
                infowindow.open(map);
            }



            google.maps.event.addDomListener(window, 'load', initAutocomplete);

        </script>

    </jsp:body>
</template:Client>