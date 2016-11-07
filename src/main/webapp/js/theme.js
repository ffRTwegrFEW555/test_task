
/* Global */

var timerSearch;
var timerAlert;

function updateView(int, action) {
    $('#refreshIcon').removeClass('hide');
    setTimeout(function() {
        var scope = angular.element(document.getElementById("userTable")).scope();
        scope.$apply(function () {
            scope.httpPostScope(int, action);
        });
    }, 500);
}

$(function () {
    $("#itemsPerPageUl li a").click(function () {
        changeButtonNameItemsPerPage($(this).text());
        updateView(0, 0);
    });

    $('#leftArrowPagination').click(function () {
        updateView(-1, 0);
    });

    $('#rightArrowPagination').click(function () {
        updateView(1, 0);
    });

    $('#removeButton').click(function () {
        var button = $(this);
        var scope = angular.element(document.getElementById("userTable")).scope();
        scope.$apply(function () {
            scope.httpPostScopeRemove(button.attr('data-userid'));
        });
        updateView(0, 0);
    });

    $('#addUserButton').click(function () {
        var name = $('#userNameAdd').val();
        var age = $('#userAgeAdd').val();

        if (name == '') {
            $('#userNameAddFormGroup').addClass('has-error');
        }
        if (age == '') {
            $('#userAgeAddFormGroup').addClass('has-error')
        }
        if (name != '' && age != '') {
            var user = {
                name: name,
                age: age,
                isAdmin: $('input[name=isAdminValueAdd]:checked').val()
            };

            var scope = angular.element(document.getElementById("userTable")).scope();
            scope.$apply(function () {
                scope.httpPostScopeAdd(user);
            });

            $('#addUserModal').modal('hide');
            $('#userNameAdd').val('');
            $('#userAgeAdd').val('');

            updateView(0, 0);
        }
    });

    $('#updateUserButton').click(function () {
        var id = $('#userId').val();
        var name = $('#userNameUpdate').val();
        var age = $('#userAgeUpdate').val();

        if (name == '') {
            $('#userNameUpdateFormGroup').addClass('has-error');
        }
        if (age == '') {
            $('#userAgeUpdateFormGroup').addClass('has-error')
        }
        if (name != '' && age != '') {
            var user = {
                id: id,
                name: name,
                age: age,
                isAdmin: $('input[name=isAdminValueUpdate]:checked').val()
            };

            var scope = angular.element(document.getElementById("userTable")).scope();
            scope.$apply(function () {
                scope.httpPostScopeUpdate(user);
            });

            $('#updateUserModal').modal('hide');
            $('#userNameUpdate').val('');
            $('#userAgeUpdate').val('');

            updateView(0, 0);
        }
    });
});


/* Bootstrap modal window */

// on open: Remove user modal
$('#removeUserModal').on('show.bs.modal', function (event) {
    var eventTarget = $(event.relatedTarget);
    var id = eventTarget.data('iduser');
    var modal = $(this);

    // filling fields
    modal.find('#removeTitleLabel').text('Remove user with id: < ' + id + ' > ?');
    modal.find('#removeButton').attr('data-userid', id);
});

// on open: Update user modal
$('#updateUserModal').on('show.bs.modal', function (event) {
    var eventTarget = $(event.relatedTarget);
    var id = eventTarget.data('iduser');
    var modal = $(this);

    // get user by id & filling fields
    var scope = angular.element(document.getElementById("userTable")).scope();
    scope.$apply(function () {
        scope.httpPostScopeGet(modal, id);
    });
});


/* Pagination */

function changeButtonNameItemsPerPage(text) {
    var string = '\&nbsp;\&nbsp;\<span class=\"caret\"\>\</span\>';
    var button = $("#itemsPerPageButton.btn:first-child");

    button.text(text).val(text);

    document.getElementById('itemsPerPageButton')
            .insertAdjacentHTML('beforeend', string);
}


/* Alerts */

function showAlert(text, alertClass) {
    var alert = $("#alertMessage");

    if (alert.find('span')[1] != null) {
        alert.find('span')[1].remove()
    }

    alert   .attr('class', 'alert alert-dismissible')
            .addClass(alertClass)
            .css('display', 'block')
            .append(text);

    clearTimeout(timerAlert);
    timerAlert = setTimeout(function () {
        alert.slideUp(500);
    }, 4000);

}


/* Angular */

var app = angular.module('testTask', []);

app.controller("userTable", ['$scope', '$http', function ($scope, $http) {
    $scope.totalCountRows   = 0;
    $scope.numberOfPage     = 0;
    $scope.paginationStart  = 0;
    $scope.paginationEnd    = 0;
    $scope.pageToView       = 0;
    $scope.textFilter       = '';
    $scope.startPosition    = 0;
    $scope.endPosition      = 0;

    // Remove user by id
    $scope.httpPostScopeRemove = function (id) {
        $http({
            method: 'POST',
            url: '/users/remove',
            params: {'id': id}
        }).then(function successCallback(response) {
            showAlert(  '\<span\>\<strong\>Success!\<\/strong\> User successfully removed (id=' + id + ')\<\/span\>',
                        'alert-success');
        }, function errorCallback(response) {
            showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> remove operation error (id=' + id + ')\<\/span\>',
                        'alert-danger');
        });
    };

    // Add user
    $scope.httpPostScopeAdd = function (user) {
        $http({
            method: 'POST',
            url: '/users/add',
            data: user
        }).then(function successCallback(response) {
            if (response.data['id'] == null || response.data['id'] == 0) {
                showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> add operation error\<\/span\>',
                            'alert-danger');
            } else {
                showAlert(  '\<span\>\<strong\>Success!\<\/strong\> User successfully added ('
                            + 'id='         + response.data['id']
                            + ', name='     + response.data['name']
                            + ', age='      + response.data['age']
                            + ', admin='    + response.data['isAdmin']
                            + ', created='  + new Date(response.data['createdDate']).toLocaleDateString() + ')\<\/span\>',
                            'alert-success');
            }
        }, function errorCallback(response) {
            showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> add operation error\<\/span\>',
                        'alert-danger');
        });
    };

    // Get user by id
    $scope.httpPostScopeGet = function (modal, id) {
        $http({
            method: 'POST',
            url: '/users/get',
            params: {'id': id}
        }).then(function successCallback(response) {
            if (response.data['id'] == null || response.data['id'] == 0) {
                $('#updateUserModal').modal('hide');
                showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> get operation error\<\/span\>',
                            'alert-danger');
            } else {
                // filling fields
                modal.find('#userId').val(response.data['id']);
                modal.find('#userCreatedDate').val(new Date(response.data['createdDate']).toLocaleDateString());
                modal.find('#userNameUpdate').val(response.data['name']);
                modal.find('#userAgeUpdate').val(response.data['age']);
                modal.find(response.data['isAdmin'] == false ? '#isAdminValueUpdateFalse' : '#isAdminValueUpdateTrue').prop("checked", true);
            }
        }, function errorCallback(response) {
            $('#updateUserModal').modal('hide');
            showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> get operation error\<\/span\>',
                        'alert-danger');
            console.log("POST /users/get: error");
        });
    };

    // Update user
    $scope.httpPostScopeUpdate = function (user) {
        $http({
            method: 'POST',
            url: '/users/update',
            data: user
        }).then(function successCallback(response) {
            if (response.data['id'] == null || response.data['id'] == 0) {
                showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> Update operation error\<\/span\>',
                            'alert-danger');
            } else {
                showAlert(  '\<span\>\<strong\>Success!\<\/strong\> User successfully updated ('
                            + 'id='         + response.data['id']
                            + ', name='     + response.data['name']
                            + ', age='      + response.data['age']
                            + ', admin='    + response.data['isAdmin']
                            + ', created='  + new Date(response.data['createdDate']).toLocaleDateString() + ')\<\/span\>',
                            'alert-success');
            }
        }, function errorCallback(response) {
            showAlert(  '\<span\>\<strong\>Danger!\<\/strong\> update operation error\<\/span\>',
                        'alert-danger');
        });
    };

    $scope.httpPostScope = function httpPost(page, strategy) {

        /*
            Strategy:

           -1 - get selected page
            0 - get prev/next/default page
        */

        if (strategy == -1) {
            $scope.numberOfPage = page;
        } else if (strategy == 0) {
            $scope.numberOfPage += page;
        } else {
            $scope.numberOfPage = 1;
        }

        $http({
            method: 'POST',
            url: '/users',
            params: {
                'itemsPerPage'  : angular.element('#itemsPerPageButton').val(),
                'numberOfPage'  : $scope.numberOfPage,
                'textFilter'    : $scope.textFilter}
        }).then(function successCallback(response) {

            $scope.userList         = response.data.userList;
            $scope.totalCountRows   = response.data['totalCountRows'];
            $scope.numberOfPage     = response.data['numberOfPage'];
            $scope.paginationStart  = response.data['paginationStart'];
            $scope.paginationEnd    = response.data['paginationEnd'];
            $scope.pageToView       = response.data['pageToView'];
            $scope.startPosition    = response.data['startPosition'];
            $scope.endPosition      = response.data['endPosition'];

            if ($scope.paginationStart == $scope.paginationEnd) {
                $('#leftArrowPagination')   .addClass('disabled');
                $('#rightArrowPagination')  .addClass('disabled');
            } else if ($scope.numberOfPage == $scope.paginationStart) {
                $('#leftArrowPagination')   .addClass('disabled');
                $('#rightArrowPagination')  .removeClass('disabled');
            } else if ($scope.numberOfPage == $scope.paginationEnd) {
                $('#leftArrowPagination')   .removeClass('disabled');
                $('#rightArrowPagination')  .addClass('disabled');
            } else {
                $('#leftArrowPagination')   .removeClass('disabled');
                $('#rightArrowPagination')  .removeClass('disabled');
            }

        }, function errorCallback(response) {
            console.log("POST /users: error");
        });

        $('#refreshIcon').addClass('hide');
    };

    $scope.httpPostScope(0, 0);

    $scope.range = function() {
        var input = [];
        for (var i = $scope.paginationStart; i <= $scope.paginationEnd; i++) {
            input.push(i);
        }

        return input;
    };

    $scope.changeSearchField = function() {
        $('#refreshIcon').removeClass('hide');

        clearTimeout(timerSearch);
        timerSearch = setTimeout(function() {
            $scope.textFilter = angular.element('#searchField').val();
            $scope.httpPostScope(0, 0);
            $('#refreshIcon').addClass('hide');
        }, 1000);
    };

    $scope.changeUserNameAddField = function() {
        $('#userNameAddFormGroup').removeClass('has-error');
    };

    $scope.changeUserAgeAddField = function() {
        $('#userAgeAddFormGroup').removeClass('has-error');
    };

    $scope.changeUserNameUpdateField = function() {
        $('#userNameUpdateFormGroup').removeClass('has-error');
    };

    $scope.changeUserAgeUpdateField = function() {
        $('#userAgeUpdateFormGroup').removeClass('has-error');
    };

}]);

