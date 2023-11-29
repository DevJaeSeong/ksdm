$(function () {
    $('.single-item').slick({
        infinite: true,
        autoplay: true,
        autoplaySpeed: 4000,
        slidesToScroll: 1,
        prevArrow: $('.slick-prev'),
        nextArrow: $('.slick-next'),
        slidesToShow: 5,
        slidesToScroll: 5,
    });
})

$(function () {

    // 사이드
    var Accordion = function(el, multiple) {
		this.el = el || {};
		this.multiple = multiple || false;

		// Variables privadas
		var links = this.el.find('.link');
		// Evento
		links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
	}

	Accordion.prototype.dropdown = function(e) {
		var $el = e.data.el;
			$this = $(this),
			$next = $this.next();

		$next.slideToggle();
		$this.parent().toggleClass('open');

		if (!e.data.multiple) {
			$el.find('.submenu').not($next).slideUp().parent().removeClass('open');
		};
	}	

	var accordion = new Accordion($('#accordion'), false);

})