<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<% String menuId = "manage"; %>
<%@include file="top.jsp" %>
<script>
$(function() {
    $("#appFile").on("change", function (event) {
        var formData = new FormData();
        formData.append("file", $(event.delegateTarget)[0].files[0]);
//        console.log("target = ", $( event.delegateTarget )[0].files[0]);
        $.ajax({
            url: '/api/apps/upload',
            processData: false,
            contentType: false,
            data: formData,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
                console.log(result.name, result.length, result.date);
                $("#fileInfo").text(result.name + " (" + toHumanSize(result.length) + ")");
                $("#fileDate").text(result.date);
                $("input[name=fileName]").val(result.name);
                $("input[name=filePath]").val(result.path);
                $("input[name=fileLength]").val(result.length);
                $("input[name=fileDate]").val(result.date);
            },
            error: function (xhr, status, e) {
                console.log("upload error = ", e);
                alert("File upload failed :" + e);
            }
        });
    });

    $("#app-edit-form").validate();

    $("#deleteAppButton").on("click", function(){
        $.ajax({
            url: "/api/apps/${app.id}",
            type: "DELETE",
            success: function() {
                location.href = "/o/manage";
            },
            error: function(xhr, status, e) {
                alert("cannot delete app : " + e);
            }
        })
    });
});


</script>
<div class="container" id="content">
    <div class="row">
        <div class="col-md-12">

            <div class="page-header">
                <h1 id="tables">EDI</h1>
            </div>

            <form id="app-edit-form" action="/o/apps/${app.id}/edit" method="POST">
                <div class="row col-md-12">
                    <a href="/o/manage" class="btn btn-default"><i class="glyphicon glyphicon-arrow-left"></i> List</a>
                    &nbsp;<a href="appInfo" class="btn btn-primary outline">Save all changes</a>
                </div>
                <div class="row col-md-12">
                    <input type="hidden" name="" value="" />
                    <h4 class="bottom-line">General Information</h4>
                    <div class="col-md-12 form-horizontal">
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Domain:</label>
                            <div class="col-md-9 col-sm-9"><p class="form-control-static">${app.id}.${domain}</p></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Name:</label>
                            <div class="col-md-9 col-sm-9"><input type="text" name="name" class="form-control required" minlength="3" value="${app.name}" /></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Description :</label>
                            <div class="col-md-9 col-sm-9"><textarea name="description" class="form-control" rows="3">${app.description}</textarea></div>
                        </div>
                    </div>
                </div>

                <div class="row col-md-12">
                    <h4 class="bottom-line">Operating Plan</h4>
                    <div class="col-md-12 form-horizontal">
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">App file:</label>
                            <div class="col-md-9 col-sm-9">
                                <p class="form-control-static"><span id="fileInfo">${app.appFile} ( ${app.appFileLengthDisplay} )</span>
                                    <br><span class="file-date" id="fileDate">${app.appFileDate}</span></p>
                                <input type="file" id="appFile" class="form-control-static"/>
                                <input type="hidden" name="fileName"/>
                                <input type="hidden" name="filePath"/>
                                <input type="hidden" name="fileLength"/>
                                <input type="hidden" name="fileDate"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Environment:</label>
                            <div class="col-md-9 col-sm-9">
                                <select name="environment" class="form-control required">
                                    <option value="">:: Select ::</option>
                                    <option value="java7_wildfly8.2">java7_wildfly8.2</option>
                                    <option value="php5_apache2">php5_apache2</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">CPUs:</label>
                            <div class="col-md-9 col-sm-9">
                                <select  name="cpus" class="form-control col-100 required">
                                    <option value="0.1">0.1</option>
                                    <option value="0.2">0.2</option>
                                    <option value="0.3">0.3</option>
                                    <option value="0.4">0.4</option>
                                    <option value="0.5">0.5</option>
                                    <option value="0.6">0.6</option>
                                    <option value="0.7">0.7</option>
                                    <option value="0.8">0.8</option>
                                    <option value="0.9">0.9</option>
                                    <option value="1.0">1.0</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Memory:</label>
                            <div class="col-md-9 col-sm-9">
                                <select name="memory" class="form-control col-100 required">
                                    <option value="300">300MB</option>
                                    <option value="400">400MB</option>
                                    <option value="500">500MB</option>
                                    <option value="600">600MB</option>
                                    <option value="700">700MB</option>
                                    <option value="800">800MB</option>
                                    <option value="900">900MB</option>
                                    <option value="1000">1GB</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Scale:</label>
                            <div class="col-md-9 col-sm-9">
                                <select name="scale"class="form-control col-100 required">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row col-md-12">
                    <h4 class="bottom-line">Resource Plan</h4>
                    <div class="col-md-12 form-horizontal">
                        <div class="form-group">
                            <input type="hidden" name="db_resource_size" value="3" />
                            <label class="col-md-3 col-sm-3 control-label">Database:</label>
                            <div class="col-md-9 col-sm-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="db1" value="DB01"> DB01 ( MySql 5.6.26 )
                                    </label>
                                </div>
                                <div class="sub-options">
                                    <label class="radio-inline">
                                        <input type="radio" name="db1_option" value="separateDB"> Separate DB
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="db1_option" value="SharedDB" disabled> Shared
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-offset-3 col-sm-offset-3 col-md-9 col-sm-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="db2" value="DB02" > DB02 ( Oracle 11g )
                                    </label>
                                </div>
                                <div class="sub-options">
                                    <label class="radio-inline">
                                        <input type="radio" name="db2_option" value="separateDB"> Separate DB
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="db2_option" value="separateSchema"> Separate Schema
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="db2_option" value="sharedSchema"> Shared
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-offset-3 col-sm-offset-3 col-md-9 col-sm-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="db3" value="DB03" > DB03 ( Postgres 9.4.4 )
                                    </label>
                                </div>
                                <div class="sub-options">
                                    <label class="radio-inline">
                                        <input type="radio" name="db3_option" value="separateDB"> Separate DB
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="db3_option" value="separateSchema"> Separate Schema
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="db3_option" value="sharedSchema"> Shared
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="ftp_resource_size" value="1" />
                            <label class="col-md-3 col-sm-3 control-label">FTP:</label>
                            <div class="col-md-9 col-sm-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="ftp1" value="FTP01"> FTP01 ( Ftp 3.2 )
                                    </label>
                                </div>
                                <div class="sub-options">
                                    <label class="radio-inline">
                                        <input type="radio" name="ftp1_option" value="private"> Private
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="ftp1_option" value="shared"> Shared
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row col-md-12">
                    <h4 class="bottom-line">Auto Scaling Plan</h4>
                    <div class="col-md-12 form-horizontal">
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Enable Auto Scale-out:</label>
                            <div class="col-md-9 col-sm-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="autoScaleOutUse" disabled> Yes
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">CPU Usage higher than:</label>
                            <div class="col-md-9 col-sm-9">
                                <select class="form-control display-inline col-100" name="cpuHigher">
                                    <option value="50">50%</option>
                                    <option value="60">60%</option>
                                    <option value="70">70%</option>
                                    <option value="80">80%</option>
                                    <option value="90">90%</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">During:</label>
                            <div class="col-md-9 col-sm-9">
                                <select class="form-control display-inline col-100" name="cpuHigherDuring">
                                    <option>1 Min</option>
                                    <option>2 Min</option>
                                    <option>3 Min</option>
                                    <option>4 Min</option>
                                    <option>5 Min</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Add Scale:</label>
                            <div class="col-md-9 col-sm-9">
                                <select class="form-control display-inline col-100" name="autoScaleOutSize">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">Enable Auto Scale-in:</label>
                            <div class="col-md-9 col-sm-9">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="autoScaleInUse" disabled> Yes
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">CPU Usage lower than:</label>
                            <div class="col-md-9 col-sm-9">
                                <select class="form-control display-inline col-100" name="cpuLower">
                                    <option value="10">10%</option>
                                    <option value="20">20%</option>
                                    <option value="30">30%</option>
                                    <option value="40">40%</option>
                                    <option value="50">50%</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-sm-3 control-label">During:</label>
                            <div class="col-md-9 col-sm-9">
                                <select class="form-control display-inline col-100" name="cpuLowerDuring">
                                    <option value="1">1 Min</option>
                                    <option value="2">2 Min</option>
                                    <option value="3">3 Min</option>
                                    <option value="4">4 Min</option>
                                    <option value="5">5 Min</option>
                                    <option value="6">6 Min</option>
                                    <option value="7">7 Min</option>
                                    <option value="8">8 Min</option>
                                    <option value="9">9 Min</option>
                                    <option value="10">10 Min</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row col-md-12">
                    <hr>
                    <div>
                        <button type="submit" class="btn btn-primary outline">Save all changes</button>
                    </div>
                </div>
            </form>

            <div class="row col-md-12">
                <br>
                <br>
                <div class="box" >
                    <div class="pull-right">
                        <button type="button" class="btn btn-lg btn-danger outline" data-toggle="modal" data-target="#deleteModal"><i class="glyphicon glyphicon-trash"></i> Delete App</button>
                    </div>
                    <h2>Delete App</h2>
                    <p>This will terminate running app and permanently delete all app information.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Are you sure?</h4>
            </div>
            <div class="modal-body">
                <p>This will terminate running app and permanently delete all app information.</p>
                <p><strong class="text-danger">Delete app "${app.id}".</strong></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-danger" id="deleteAppButton">Yes</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@include file="bottom.jsp" %>