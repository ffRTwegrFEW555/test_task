<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" ng-app="testTask">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>test App</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Personal theme -->
    <link href="css/theme.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<!-- ======================= -->

<!-- Fixed navbar -->
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <span class="navbar-brand glyphicon glyphicon-user" style="color: #9d9d9d; font-size: x-large"></span>
        <a class="navbar-brand" href="#">testApp for traineeship</a>
    </div>
</nav>

<!-- Main -->
<div class="container" role="main" ng-controller="userTable" id="userTable">

    <!-- Header text -->
    <div class="page-header">
        <h1>CRUD application</h1>
        <p>Using AngularJS, Bootstrap, Java, Hibernate, Spring, Tomcat 8, Maven, MySql</p>
    </div>

    <!-- Alerts -->
    <div id="alertMessage" class="alert alert-success alert-dismissible" style="display: none" role="alert">
        <button type="button" class="close" onclick="$('#alertMessage').css('display', 'none')" aria-label="Close"><span aria-hidden="true">×</span>
        </button>
    </div>

    <!-- Panel -->
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Users table</h3>
        </div>
        <div class="panel-body">
            <!-- Nav panel -->
            <div style="margin-bottom: 20px; margin-top: 20px">

                <!-- Add user -->
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addUserModal"
                        data-whatever="addUser">
                    <span class="glyphicon glyphicon-plus" style="color: #777"></span>&nbsp;&nbsp;Add user
                </button>

                <!-- Modal window: add user-->
                <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Add new user:</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div id="userNameAddFormGroup" class="form-group">
                                        <label for="userNameAdd" class="control-label">Name:</label>
                                        <input type="text" class="form-control" id="userNameAdd" ng-model="userNameAdd" ng-change="changeUserNameAddField()">
                                    </div>
                                    <div id="userAgeAddFormGroup" class="form-group">
                                        <label for="userAgeAdd" class="control-label">Age:</label>
                                        <input type="number" min="0" max="200" step="1" maxlength="3"
                                               class="form-control" id="userAgeAdd" ng-model="userAgeAdd" ng-change="changeUserAgeAddField()">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">is Admin?:</label>
                                        <div class="radio">
                                            <label><input type="radio" name="isAdminValueAdd" value="false"
                                                          checked>No</label>
                                        </div>
                                        <div class="radio">
                                            <label><input type="radio" name="isAdminValueAdd" value="true">Yes</label>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" id="addUserButton">Add new user</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal window: update user -->
                <div class="modal fade" id="updateUserModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="exampleModalLabel">Edit current user:</h4>
                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group" id="userIdGroup">
                                        <label for="userId" class="control-label">Id:</label>
                                        <input type="text" class="form-control" id="userId" disabled>
                                    </div>
                                    <div class="form-group" id="userCreatedDateGroup">
                                        <label for="userCreatedDate" class="control-label">Created date:</label>
                                        <input type="text" class="form-control" id="userCreatedDate" disabled>
                                    </div>
                                    <div id="userNameUpdateFormGroup" class="form-group">
                                        <label for="userNameUpdate" class="control-label">Name:</label>
                                        <input type="text" class="form-control" id="userNameUpdate" ng-model="userNameUpdate" ng-change="changeUserNameUpdateField()">
                                    </div>
                                    <div id="userAgeUpdateFormGroup" class="form-group">
                                        <label for="userAgeUpdate" class="control-label">Age:</label>
                                        <input type="number" min="0" max="200" step="1" maxlength="3"
                                               class="form-control" id="userAgeUpdate" ng-model="userAgeUpdate" ng-change="changeUserAgeUpdateField()">
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label">is Admin?:</label>
                                        <div class="radio">
                                            <label><input id="isAdminValueUpdateFalse" type="radio" name="isAdminValueUpdate" value="false"
                                                          checked>No</label>
                                        </div>
                                        <div class="radio">
                                            <label><input id="isAdminValueUpdateTrue" type="radio" name="isAdminValueUpdate" value="true">Yes</label>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" id="updateUserButton">Save changes</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal window: remove user -->
                <div id="removeUserModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
                     aria-labelledby="mySmallModalLabel">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                        aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="removeTitleLabel">Remove user</h4></div>
                            <div class="modal-body">
                                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin: 0 70px 0 20px">Cancel</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal" id="removeButton">Remove</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Search form -->
                <div class="input-group col-xs-6 pull-right">
                    <span class="input-group-addon">Search:</span>
                    <input id="searchField" class="form-control" placeholder="example: Margarette Johns.." ng-model="searchField" ng-change="changeSearchField()">
                </div>
                <span id="refreshIcon" class="hide glyphicon glyphicon-refresh gly-spin" style="color: #ccc; font-size: large; float: right; margin: 7px"></span>

            </div>

            <!-- Table -->
            <table class="table table-hover table-condensed table-striped">
                <thead>
                <tr>
                    <th class="col-xs-1">id</th>
                    <th>name</th>
                    <th class="col-xs-1">age</th>
                    <th class="col-xs-1">is_admin?</th>
                    <th class="col-xs-1">created_date</th>
                    <th class="col-xs-1">edit/remove</th>
                </tr>
                </thead>
                <tbody>
                <tr ng-repeat="user in userList">
                    <td>{{user.id}}</td>
                    <td>{{user.name}}</td>
                    <td>{{user.age}}</td>
                    <td>{{user.isAdmin == false ? 'нет' : 'да'}}</td>
                    <td>{{user.createdDate | date:'yyyy-MM-dd'}}</td>
                    <td align="center">
                        <a href="#" data-toggle="modal" data-target="#updateUserModal"
                           data-whatever="editUser" data-iduser="{{user.id}}">
                            <span class="glyphicon glyphicon-edit" style="color: green; font-size: large"></span>
                        </a>
                        &nbsp;&nbsp;
                        <a href="#" data-toggle="modal" data-target="#removeUserModal" data-iduser="{{user.id}}">
                            <span class="glyphicon glyphicon-remove" style="color: lightcoral; font-size: large"></span>
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>

            <!-- Pagination info -->
            <div style="float: left; margin-top: 25px ; padding-right: 10px;">
                <p><b>Result:</b> {{totalCountRows == 0 ? '0' : (startPosition + 1) + ' - ' + endPosition + ', total: ' + totalCountRows}}</p>
            </div>

            <!-- Pagination block -->
            <div style="float: right">

                <!-- Label -->
                <div style="float: left; margin-top: 25px ; padding-right: 10px;">
                    <p>Items per page:</p>
                </div>

                <!-- Dropdown button -->
                <div class="dropdown" style="float: left; margin: 20px 0px 20px 0px; padding-right: 20px">
                    <button id="itemsPerPageButton" class="btn btn-default btn-sm dropdown-toggle" type="button"
                            id="dropdownMenu1"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width: 60px">10&nbsp;&nbsp;<span
                            class="caret"></span>
                    </button>
                    <ul id="itemsPerPageUl" class="dropdown-menu" aria-labelledby="dropdownMenu1">
                        <li><a href="#">10</a></li>
                        <li><a href="#">20</a></li>
                        <li><a href="#">100</a></li>
                    </ul>
                </div>

                <!-- Pagination -->
                <ul class="pagination pagination-sm">
                    <li id="leftArrowPagination">
                        <a href="#" aria-label="Previous">
                        <span aria-hidden="true">
                            <span class="glyphicon glyphicon-triangle-left" aria-hidden="true"></span>
                        </span>
                        </a>
                    </li>
                    <li data-pageNumber="{{n}}" onclick="updateView(this.getAttribute('data-pageNumber'), -1)" ng-repeat="n in range()" class="{{n == numberOfPage ? 'active' : ''}}" ><a href="#">{{n}}<span class="sr-only">(current)</span></a>
                    </li>
                    <li id="rightArrowPagination">
                        <a href="#" aria-label="Next">
                        <span aria-hidden="true">
                        <span class="glyphicon glyphicon-triangle-right" aria-hidden="true"></span>
                        </span>
                        </a>
                    </li>
                </ul>

            </div>

        </div>
    </div>
</div>


<!-- ======================= -->

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
<!-- AngularJS -->
<script src="js/angular.min.js"></script>
<!-- Personal theme -->
<script src="js/theme.js"></script>
</body>
</html>