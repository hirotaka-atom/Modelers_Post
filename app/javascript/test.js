document.addEventListener("turbolinks:load", function() {
  $(function(){
      $("#alert").fadeOut(5000);
  });

  $(function() {
      function readURL(input) {
          if (input.files && input.files[0]) {
          var reader = new FileReader();
          reader.onload = function (e) {
      $('#img_prev').attr('src', e.target.result);
          }
          reader.readAsDataURL(input.files[0]);
          }
      }
      $("#img").change(function(){
          readURL(this);
      });
  });

  $(function(){
    $('#hamburger').on('click', function(){
          $('.icon').toggleClass('close');
          $('.sm').slideToggle();
    });
  });

  $(function(){
    $('.sub-menu').on('click', function(){
      $('.dropdown-menu').slideToggle();
    });
  });

  const Tabs = {
  init() {
    let promise = $.Deferred();
    this.$tabs = $('ul.nav-tabs');
    this.checkHash();
    this.bindEvents();
    this.onLoad();
    return promise;
  },

  checkHash() {
    if (window.location.hash) {
      this.toggleTab(window.location.hash);
    }
  },

  toggleTab(tab) {
    // targets
    var $paneToHide = $(tab).closest('.container').find('div.content-pane').filter('.is-active'),
      $paneToShow = $(tab),
      $tab = this.$tabs.find('a[href="' + tab + '"]');

    // toggle active tab
    $tab.closest('li').addClass('active').siblings('li').removeClass('active');

    // toggle active tab content
    $paneToHide.removeClass('is-active').addClass('is-animating is-exiting');
    $paneToShow.addClass('is-animating is-active');
  },

  showContent(tab) {

  },

  animationEnd(e) {
    $(e.target).removeClass('is-animating is-exiting');
  },

  tabClicked(e) {
    e.preventDefault();
    this.toggleTab(e.target.hash);
  },

  bindEvents() {
    // show/hide the tab content when clicking the tab button
    this.$tabs.on('click', 'a', this.tabClicked.bind(this));

    // handle animation end
    $('div.content-pane').on('transitionend webkitTransitionEnd', this.animationEnd.bind(this));
  },

  onLoad() {
    $(window).load(function() {
      $('div.content-pane').removeClass('is-animating is-exiting');
    });
  }
  }

  Tabs.init();
});
