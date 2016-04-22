<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title"><spring:message code="rec-info"/></h4>
</div>
<div class="modal-body">
    <form role="form"  class="form-horizontal">
        <div class="form-group name">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.name_of_recipient"/><span class="errors">*</span></label>
            </div>
            <div class="col-lg-7 col-md-7">
                ${rec.fullName}
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.email_of_recipient"/></label>
            </div>
            <div class="col-lg-7 col-md-7">
                ${rec.email}
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.phone_of_recipient"/><span class="errors">*</span></label>
            </div>
            <div class="col-lg-7 col-md-7">
                ${rec.phone}
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-5 col-md-5">
                <label class="control-label"><spring:message code="gift.note"/></label>
            </div>
            <div class="col-lg-7 col-md-7">
                ${rec.note}
            </div>
        </div>
    </form>
</div>