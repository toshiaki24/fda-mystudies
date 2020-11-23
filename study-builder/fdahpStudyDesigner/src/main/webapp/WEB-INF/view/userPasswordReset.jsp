<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page session="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html class="overflow-hidden" lang="">
  <head>

    <!-- Basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Study Builder</title>

    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">

    <!-- Favicon -->
    <link rel="shortcut icon" href="/studybuilder/images/icons/FAV_Icon.png"
          type="image/x-icon"/>
    <link rel="apple-touch-icon"
          href="/studybuilder/images/icons/FAV_Icon.png">

    <!-- Mobile Metas -->
    <meta name="viewport"
          content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <!-- Web Fonts  -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400"
          rel="stylesheet">

    <!-- Vendor CSS -->
    <link rel="stylesheet" href="vendor/boostrap/bootstrap.min.css">
    <link rel="stylesheet"
          href="vendor/datatable/css/dataTables.bootstrap.min.css">

    <!-- Your custom styles (optional) -->
    <link href="/studybuilder/css/loader.css" rel="stylesheet">

    <link rel="stylesheet" href="vendor/dragula/dragula.min.css">
    <link rel="stylesheet" href="vendor/magnific-popup/magnific-popup.css">
    <link rel="stylesheet" href="vendor/animation/animate.css">

    <!-- Theme Responsive CSS -->
    <link rel="stylesheet" href="css/layout.css">

    <!-- Theme CSS -->
    <link rel="stylesheet" href="css/theme.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/jquery-password-validator.css"></link>

    <!-- Head Libs -->
    <script src="vendor/modernizr/modernizr.js"></script>


  </head>
  <body class="loading background__img">
    <div id="loader">
      <span></span>
    </div>
    <div id="lg-container" class="lg-container">

      <div class="logo__space">
        <img src="images/logo/logo_landing_welcome.png" alt=""/>
      </div>

      <div class="login__container">
        <input type="hidden" id="csrfDet"
               csrfParamName="${_csrf.parameterName}" csrfToken="${_csrf.token}"/>
        <div>
          <form:form id="passwordResetForm" data-toggle="validator"
                     role="form" action="addPassword.do" method="post"
                     autocomplete="off">
            <div id="errMsg" class="error_msg">${errMsg}</div>
            <div id="sucMsg" class="suceess_msg">${sucMsg}</div>
            <c:if test="${not isInactiveUser && isValidToken}">
              <div>
              <p class="white__text">Please set up your new password using
                this form. You would be required to enter the access code
                provided to you over email for the same.</p>
              <div class="mb-lg form-group">
                <input autofocus="autofocus" type="text"
                       class="input-field wow_input" id="" tabindex="1"
                       name="accessCode" maxlength="6" placeholder="Access Code"
                       data-error="Access Code is invalid" required autocomplete="off"/>
                <div class="help-block with-errors red-txt"></div>
              </div>
              <div class="mb-lg form-group">
                <input type="password" class="input-field wow_input"
                       id="password" tabindex="2" maxlength="64" data-minlength="8"
                       placeholder="Password" required
                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!&quot;#$%&amp;'()*+,-.:;&lt;=&gt;?@[\]^_`{|}~])[A-Za-z\d!&quot;#$%&amp;'()*+,-.:;&lt;=&gt;?@[\]^_`{|}~]{8,64}"
                       data-error="Password is invalid" autocomplete="off"/>
                <div class="help-block with-errors red-txt"></div>
                <span class="arrowLeftSugg"></span>

              </div>

              <div class="mb-lg form-group">
                <input type="password" class="input-field wow_input"
                       id="cfnPassword" tabindex="3" name="" maxlength="64"
                       data-match="#password"
                       data-match-error="Whoops, these don't match"
                       placeholder="Confirm password" required autocomplete="off"/>
                <div class="help-block with-errors red-txt"></div>
              </div>
              <div class="mb-lg form-group">
                <button type="button" class="btn lg-btn" id="resetPasswordBut">Submit
                </button>
              </div>
            </c:if>
            <c:if test="${isInactiveUser}">
              <p class="passwordExp">
                <i class="fa fa-exclamation-circle" aria-hidden="true"></i>
                Your account has been
                deactivated.
              </p>
            </c:if>
            <c:if test="${not isInactiveUser && not isValidToken}">
              <p class="passwordExp">
                <i class="fa fa-exclamation-circle" aria-hidden="true"></i>
                The
                Password Reset Link is either expired or invalid.
              </p>
            </c:if>
            <div>
              <a id="login" class="gray-link backToLogin white__text"
                 href="javascript:void(0)">Back to Sign in
              </a>
            </div>
            </div>
            <input type="hidden" name="securityToken" value="${securityToken}"/>
            <input type="password" name="password" id="hidePass"
                   style="display: none;"/>
          </form:form>
        </div>


        <div class="clearfix"></div>

        <div class="footer">
          <span>Copyright Placeholder</span>
          <span>
            <a href="/studybuilder/terms.do" id="" target="_blank">Terms</a>
          </span>
          <span>
            <a href="/studybuilder/privacyPolicy.do" id="" target="_blank">Privacy Policy</a>
          </span>
        </div>

      </div>
      <!-- End Login Right Section-->
      <!-- Modal -->
      <div class="modal fade" id="termsModal" role="dialog">
        <div class="modal-dialog modal-lg">
          <!-- Modal content-->
          <div class="modal-content">

            <div class="modal-header cust-hdr">
              <button type="button" class="close pull-right" data-dismiss="modal">&times;
              </button>
            </div>
            <div class="modal-body pt-xs pb-lg pl-xlg pr-xlg">
              <div>
                <div class="mt-md mb-md">
                  <u><strong>Terms</strong></u>
                </div>
                <span>${masterDataBO.termsText}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="modal fade" id="privacyModal" role="dialog">
        <div class="modal-dialog modal-lg">
          <!-- Modal content-->
          <div class="modal-content">

            <div class="modal-header cust-hdr">
              <button type="button" class="close pull-right" data-dismiss="modal">&times;
              </button>
            </div>

            <div class="modal-body pt-xs pb-lg pl-xlg pr-xlg">
              <div>
                <div class="mt-md mb-md">
                  <u><strong>Privacy Policy</strong></u>
                </div>
                <span>${masterDataBO.privacyPolicyText}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
    <form:form action="/studybuilder/login.do" id="backToLoginForm"
               name="backToLoginForm" method="post">
    </form:form>

    <!-- Vendor -->
    <script src="vendor/jquery/jquery-3.1.1.min.js"></script>
    <script src="vendor/boostrap/bootstrap.min.js"></script>
    <script src="vendor/animation/wow.min.js"></script>
    <script src="vendor/datatable/js/jquery.dataTables.min.js"></script>
    <script src="vendor/dragula/react-dragula.min.js"></script>
    <script src="vendor/magnific-popup/jquery.magnific-popup.min.js"></script>
    <script src="vendor/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/validator.min.js"></script>
    <script src="/studybuilder/js/jquery.mask.min.js"></script>
    <script src="/studybuilder/js/jquery.password-validator.js"></script>
    <script type="text/javascript" src="/studybuilder/js/loader.js"></script>
    <script type="text/javascript"
            src="/studybuilder/js/jquery.password-validator.js"></script>
    <script src="/studybuilder/js/underscore-min.js"></script>

    <!-- Theme Custom JS-->
    <script src="/studybuilder/js/theme.js"></script>
    <script src="/studybuilder/js/common.js"></script>
    <!--common js-->


    <script>
      $(document).ready(function (e) {

        $('#termsId').on('click', function () {
          $('#termsModal').modal('show');
        });

        $('#privacyId').on('click', function () {
          $('#privacyModal').modal('show');
        });

        addPasswordPopup();
        $('.backToLogin').on('click', function () {
          $('#backToLoginForm').submit();
        });

        var errMsg = '${errMsg}';
        var isValidToken = '${isValidToken}';
        if (isValidToken) {
          if (errMsg.length > 0) {
            $("#errMsg").text(errMsg);
            $("#errMsg").show("fast");
            setTimeout(hideDisplayMessage, 4000);
          }
        }
        var sucMsg = '${sucMsg}';
        if (isValidToken) {
          if (sucMsg.length > 0) {
            $("#sucMsg").text(sucMsg);
            $("#sucMsg").show("fast");
            $("#errMsg").hide("fast");
            setTimeout(hideDisplayMessage, 4000);
          }
        }
        $("#password").passwordValidator({
          // list of qualities to require
          require: ['length', 'lower', 'upper', 'digit', 'spacial'],
          // minimum length requirement
          length: 8
        });

      });

      function hideDisplayMessage() {
        $('#sucMsg').hide();
        $('#errMsg').hide();
      }

      window.onload = function () {
        if (typeof history.pushState === "function") {
          history.pushState("jibberish", null, null);
          window.onpopstate = function () {
            history.pushState('newjibberish', null, null);
            // Handle the back (or forward) buttons here
            // Will NOT handle refresh, use onbeforeunload for this.
          };
        } else {
          var ignoreHashChange = true;
          window.onhashchange = function () {
            if (!ignoreHashChange) {
              ignoreHashChange = true;
              window.location.hash = Math.random();
              // Detect and redirect change here
              // Works in older FF and IE9
              // * it does mess with your hash symbol (anchor?) pound sign
              // delimiter on the end of the URL
            } else {
              ignoreHashChange = false;
            }
          };
        }
        $(document).find('.md-container.white-bg ').removeClass(
            'md-container');
      }

      var addPasswordPopup = function () {
        $("#password").passwordValidator({
          // list of qualities to require
          require: ['length', 'lower', 'upper', 'digit', 'spacial'],
          // minimum length requirement
          length: 8
        });
      }
    </script>

  </body>
</html>