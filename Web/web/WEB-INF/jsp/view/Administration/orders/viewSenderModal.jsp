<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title">Sender Information</h4>
</div>
<div class="modal-body">
    <form role="form"  class="form-horizontal">
                <div class="form-group name">
                    <div class="col-lg-5 col-md-5">
                        <label class="control-label">Full Name:</label>
                </div>
                <div class="col-lg-7 col-md-7">
                    ${sender.fullName}
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-5 col-md-5">
                    <label class="control-label">Email:</label>
                </div>
                <div class="col-lg-7 col-md-7">
                    ${sender.email}
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-5 col-md-5">
                    <label class="control-label">Phone:</label>
                </div>
                <div class="col-lg-7 col-md-7">
                    ${sender.phone}
                </div>
            </div>
    </form>
</div>