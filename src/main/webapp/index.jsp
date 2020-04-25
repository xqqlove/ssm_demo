<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/24
  Time: 1:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        //        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/static/js/jquery.min.js" type="text/javascript"></script>

    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>

<body>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="name" class="col-sm-3 control-label">员工姓名：</label>
                        <div class="col-sm-9">
                            <input type="email" class="form-control" id="name" placeholder="name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">性别：</label>
                        <div class="col-sm-9">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1" value="gender1"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2" value="gender2"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-3 control-label">邮箱：</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="email" placeholder="email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="department" class="col-sm-3 control-label">所在部门：</label>
                        <div class="col-sm-9">
                            <select class="form-control" id="department">
                                <option value="1">开发部</option>
                                <option value="2">测试部</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="close">Close</button>
                <button type="button" class="btn btn-primary" id="save">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary"  id="add_employee">新增</button>
            <button type="button" class="btn btn-primary">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-bordered" id="emp_table">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">empName</th>
                    <th scope="col">gender</th>
                    <th scope="col">email</th>
                    <th scope="col">deptName</th>
                    <th scope="col">操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" id="page_info_area"></div>
        <div class="col-md-6" id="page_nav_area"></div>

    </div>

</div>
<script type="text/javascript">
    $(function () {
        $.ajax({
            url: "/emps",
            data: "pn=1",
            type: "GET",
            success: function (result) {
                console.log(result)
                build_emps_table(result);
                build_page_info(result);
                build_page_navigation(result);
            }
        })
    })

    function build_emps_table(result) {
        $("#emp_table tbody").empty();
        var emp = result.list;
        $.each(emp, function (index, item) {
            var empId = $("<td></td>").append(item.empId);
            var empName = $("<td></td>").append(item.empName);
            var gender = $("<td></td>").append(item.gender == 1 ? "男" : "女");
            var email = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.dId == 1 ? "开发部" : "测试部");
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            var btnId = $("<td></td>").append(editBtn).append(delBtn);
            $("<tr></tr>").append(empId)
                .append(empName).append(gender)
                .append(email).append(deptName)
                .append(btnId).appendTo("#emp_table tbody");
        })
    }

    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.pageNum + "页，总共" + result.pages + "页，总共" + result.total + "条记录");
    }
    function to_page(n) {
        $(function () {
            $.ajax({
                url: "/emps",
                data: "pn="+n,
                type: "GET",
                success: function (result) {
                    console.log(result)
                    build_emps_table(result);
                    build_page_info(result);
                    build_page_navigation(result);
                }
            })
        })
    }
    function build_page_navigation(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var liLeft = $("<li></li>").append($("<a></a>").append("&laquo;"));
        liLeft.click(function () {
            to_page(result.pageNum-1);
        })
        var liRight = $("<li></li>").append($("<a></a>").append("&raquo;"));
        liRight.click(function () {
            to_page(result.pageNum+1);
        })
        ul.append(liLeft);
        $.each(result.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.pageNum==item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        })
        ul.append(liRight);
        var nav = $("<nav aria-label='Page navigation'></nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }
    $("#add_employee").click(function () {
        $('#myModal').modal({
            backdrop:"static"
        })
    })
</script>

</body>
</html>
