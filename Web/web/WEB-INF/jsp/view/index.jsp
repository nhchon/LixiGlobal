<template:Client htmlTitle="Home - LiXi Global">

    <jsp:attribute name="extraHeadContent">
    </jsp:attribute>

    <jsp:attribute name="extraJavascriptContent">
        <script type="text/javascript">
        </script>
    </jsp:attribute>

    <jsp:body>
        <section class="section-slider section-slider-thumb text-right">
        </section>

        <section class="section-gift bg-default">
            <div class="container">
                <div class="section-gift-top">
                    <h2 class="text-center ">Gifting overseas has never been easier...<br/>
                        <strong>in three easy steps</strong><br/> 
                        with a simple fee of just <strong>USD $ 1.00<sup>*</sup></strong></h2>
                    <div class="change-curency-box">
                        <div class="btn-group">
                            <button class="btn change-curency-box-des" type="button">
                                <span class="des-box">Your locked-in exchange rate</span>
                                <span class="amount-box">USD $ 1 = <strong>VND 23,000</strong> Vietnam Dong</span>
                            </button>
                            <button data-toggle="dropdown" class="btn dropdown-toggle" type="button">
                                <span class="flag flag-vn"></span>
                                <i class="fa fa-chevron-down"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right">
                                <li><a class="flag-link" href="#change-rate" rel="tooltip" title="English"><span class="flag flag-en"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="section-gift-bottom text-center">
                    <div class="row">
                        <div class="col-md-3 col-sm-3">
                            <div class="gif-by-step">
                                <span class="fa-stack fa-6x fa-stack-gift">
                                    <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                    <i class="fa fa-newspaper-o fa-stack-1x fa-stack-custom fa-inverse"></i>
                                </span>
                                <div class="clearfix"></div>
                                <h3>Choose the gift<br/>you want to buy</h3>
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1 col-xs-1 col-has-gift-arrow">
                            <div class="arrow-right">
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="gif-by-step">
                                <span class="fa-stack fa-6x fa-stack-gift">
                                    <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                    <i class="fa fa-credit-card fa-stack-1x fa-stack-custom  fa-inverse"></i>
                                </span>
                                <div class="clearfix"></div>
                                <h3>Pay by Credit/Debit Card<br/> or with bank account
                            </div>
                        </div>
                        <div class="col-md-1 col-sm-1 col-xs-1  col-has-gift-arrow">
                            <div class="arrow-right">
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-3">
                            <div class="gif-by-step">
                                <span class="fa-stack fa-6x fa-stack-gift">
                                    <i class="fa fa-circle fa-stack-2x text-primary"></i>
                                    <i class="fa fa-send fa-stack-1x fa-stack-custom  fa-inverse"></i>
                                </span>
                                <div class="clearfix"></div>
                                <h3>Confirmation is sent<br/>
                                    right away<br/>
                                    to the receiver </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="gift-category">
                    <h2 class="title text-center"><span>gift select your category</span></h2>
                    <div class="gift-category-content">
                        <div class="row">
                            <div class="col-md-3 col-sm-3">
                                <div class="gift-item">
                                    <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-01.png"/>) no-repeat scroll 0% 0%"></div>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="#shop-now">${LIXI_CATEGORIES.perfume.english}</a></h2>
                                            <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="gift-item">
                                    <div class="gift-item-col-thumb" style="background: transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-03.png"/>) no-repeat scroll 0% 0%; min-height: 182px;"></div>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="#shop-now">MOBILE CARDS</a></h2>
                                            <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-9 col-sm-9">
                                <div class="row">
                                    <div class="col-md-6 col-sm-6">
                                        <div class="gift-item">
                                            <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-04.png"/>) no-repeat scroll 0% 0%; min-height: 287px;"></div>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title">${LIXI_CATEGORIES.cosmetics.english}</h2>
                                                    <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-sm-6">
                                        <div class="gift-item gift-item-text-on-left">
                                            <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-05.png"/>) no-repeat scroll 0% 0%"></div>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="#shop-now">${LIXI_CATEGORIES.candies.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="gift-item gift-item-text-on-left">
                                            <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-06.png"/>) no-repeat scroll 0% 0%"></div>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="#shop-now">${LIXI_CATEGORIES.flowers.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="gift-item gift-item-text-on-right">
                                            <div class="gift-item-col-thumb" style="background:  transparent url(<c:url value="/resource/theme/assets/lixi-global/images/img-02.png"/>) no-repeat scroll 0% 0%"></div>
                                            <div class="gift-item-col-content">
                                                <div class="gift-item-col-content-text">
                                                    <span class="gift-arrow-item gift-arrow-item-top"></span>
                                                    <h2 class="gift-item-col-content-title"><a href="#shop-now">${LIXI_CATEGORIES.jewelries.english}</a></h2>
                                                    <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="gift-item gift-item-text-on-right gift-item-text-full">
                                    <div class="gift-item-col-thumb" style="background: url(<c:url value="/resource/theme/assets/lixi-global/images/img-07.png"/>)"></div>
                                    <div class="gift-item-col-content">
                                        <div class="gift-item-col-content-text">
                                            <span class="gift-arrow-item gift-arrow-item-top"></span>
                                            <h2 class="gift-item-col-content-title"><a href="#shop-now">${LIXI_CATEGORIES.childrentoy.english}</a></h2>
                                            <div class="gift-item-col-content-link"><a href="#shop-now">Shop now <i class="fa fa-chevron-right"></i></a></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </jsp:body>
</template:Client>