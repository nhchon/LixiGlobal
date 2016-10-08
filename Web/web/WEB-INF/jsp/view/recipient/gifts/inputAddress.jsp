<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<template:Client htmlTitle="Receiver's Address - Lixi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
            /** Page Script **/
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-gift bg-default main-section">
            <div class="container post-wrapper" style="padding-top:30px;">
                <div class="section-receiver">
                    <h2 class="title">Please Input Your address</h2>
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form:form modelAttribute="addressForm">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Receiver's info:<a href="<c:url value="/user/yourAccount"/>">(Change info)</a></label><br/>
                                            ${sessionScope['scopedTarget.loginedUser'].firstName}&nbsp;
                                            ${sessionScope['scopedTarget.loginedUser'].middleName}&nbsp;
                                            ${sessionScope['scopedTarget.loginedUser'].lastName}&nbsp;<br/>
                                            ${sessionScope['scopedTarget.loginedUser'].email}<br/>
                                            ${sessionScope['scopedTarget.loginedUser'].phone}<br/>
                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <label>Receiver's Address</label>
                                            <form:input type="text" path="recAddress" class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Province</label>
                                            <form:select path="recProvince" class="form-control">
                                                <option value="Hà Nội">Hà Nội</option>
                                                <option value="TP HCM">TP HCM</option>
                                                <option value="Hải Phòng">Hải Phòng</option>
                                                <option value="Đà Nẵng">Đà Nẵng</option>
                                                <option value="Cần Thơ">Cần Thơ</option>
                                                <option value="An Giang">An Giang</option>
                                                <option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu</option>
                                                <option value="Bắc Giang">Bắc Giang</option>
                                                <option value="Bắc Kạn">Bắc Kạn</option>
                                                <option value="Bạc Liêu">Bạc Liêu</option>
                                                <option value="Bắc Ninh">Bắc Ninh</option>
                                                <option value="Bến Tre">Bến Tre</option>
                                                <option value="Bình Định">Bình Định</option>
                                                <option value="Bình Dương">Bình Dương</option>
                                                <option value="Bình Phước">Bình Phước</option>
                                                <option value="Bình Thuận">Bình Thuận</option>
                                                <option value="Cà Mau">Cà Mau</option>
                                                <option value="Cao Bằng">Cao Bằng</option>
                                                <option value="Đắk Lắk">Đắk Lắk</option>
                                                <option value="Đắk Nông">Đắk Nông</option>
                                                <option value="Điện Biên">Điện Biên</option>
                                                <option value="Đồng Nai">Đồng Nai</option>
                                                <option value="Đồng Tháp">Đồng Tháp</option>
                                                <option value="Gia Lai">Gia Lai</option>
                                                <option value="Hà Giang">Hà Giang</option>
                                                <option value="Hà Nam">Hà Nam</option>
                                                <option value="Hà Tĩnh">Hà Tĩnh</option>
                                                <option value="Hải Dương">Hải Dương</option>
                                                <option value="Hậu Giang">Hậu Giang</option>
                                                <option value="Hòa Bình">Hòa Bình</option>
                                                <option value="Hưng Yên">Hưng Yên</option>
                                                <option value="Khánh Hòa">Khánh Hòa</option>
                                                <option value="Kiên Giang">Kiên Giang</option>
                                                <option value="Kon Tum">Kon Tum</option>
                                                <option value="Lai Châu">Lai Châu</option>
                                                <option value="Lâm Đồng">Lâm Đồng</option>
                                                <option value="Lạng Sơn">Lạng Sơn</option>
                                                <option value="Lào Cai">Lào Cai</option>
                                                <option value="Long An">Long An</option>
                                                <option value="Nam Định">Nam Định</option>
                                                <option value="Nghệ An">Nghệ An</option>
                                                <option value="Ninh Bình">Ninh Bình</option>
                                                <option value="Ninh Thuận">Ninh Thuận</option>
                                                <option value="Phú Thọ">Phú Thọ</option>
                                                <option value="Phú Yên">Phú Yên</option>
                                                <option value="Quảng Bình">Quảng Bình</option>
                                                <option value="Quảng Nam">Quảng Nam</option>
                                                <option value="Quảng Ngãi">Quảng Ngãi</option>
                                                <option value="Quảng Ninh">Quảng Ninh</option>
                                                <option value="Quảng Trị">Quảng Trị</option>
                                                <option value="Sóc Trăng">Sóc Trăng</option>
                                                <option value="Sơn La">Sơn La</option>
                                                <option value="Tây Ninh">Tây Ninh</option>
                                                <option value="Thái Bình">Thái Bình</option>
                                                <option value="Thái Nguyên">Thái Nguyên</option>
                                                <option value="Thanh Hóa">Thanh Hóa</option>
                                                <option value="Thừa Thiên Huế">Thừa Thiên Huế</option>
                                                <option value="Tiền Giang">Tiền Giang</option>
                                                <option value="Trà Vinh">Trà Vinh</option>
                                                <option value="Tuyên Quang">Tuyên Quang</option>
                                                <option value="Vĩnh Long">Vĩnh Long</option>
                                                <option value="Vĩnh Phúc">Vĩnh Phúc</option>
                                                <option value="Yên Bái">Yên Bái</option>

                                            </form:select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="form-group">
                                            <button class="btn btn-primary" type="submit"><spring:message code="message.save"/></button>
                                            <button class="btn btn-warning" type="button" onclick="location.href='<c:url value="/recipient/gifts"/>'"><spring:message code="message.cancel"/></button>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>