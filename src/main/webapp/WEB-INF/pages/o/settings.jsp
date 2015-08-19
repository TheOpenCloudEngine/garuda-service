<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<% String menuId = "settings"; %>
<%@include file="top.jsp" %>

<script>
    function showUsers() {
        $('#user-list').modal();
    }
</script>
<div class="container" id="content">
    <div class="row">
        <div class="col-md-12">

            <div class="page-header">
                <h1 id="tables">Organization Settings</h1>
            </div>

            <div>
                <%--<div class="pull-right">--%>
                    <%--<a href="#" class="btn btn-lg btn-primary outline">Edit</a>--%>
                <%--</div>--%>
                <h3>${organization.name} (${organization.id})</h3>
                <p>Member Since ${joinDate}</p>
                <p>
                    <a href="javascript:showUsers()">${fn:length(users)} Users</a>
                </p>
            </div>

            <br>

            <div class="box" >
                <div class="pull-right">
                    <a href="#${organization.id}" class="btn btn-lg btn-danger outline">Delete Organization</a>
                </div>
                <h2>Delete Organization</h2>
                <p>This will permanently delete all users, apps and organization information.</p>
            </div>

        </div>
    </div>
</div>

<div class="modal" id="user-list" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Users</h4>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                    <th>#</th>
                    <th>ID</th>
                    <th>Type</th>
                    <th>Join Time</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${not empty users}">
                        <c:forEach var="user" items="${users}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${user.id}</td>
                            <td>
                                <c:if test="${user.type eq 'A'}">
                                    Administrator
                                </c:if>
                                <c:if test="${user.type eq 'U'}">
                                    User
                                </c:if>
                            </td>
                            <td>${user.joinDate}</td>
                        </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%@include file="bottom.jsp" %>
