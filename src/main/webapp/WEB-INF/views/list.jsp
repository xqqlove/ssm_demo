<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/4/25
  Time: 15:35
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
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="/static/js/jquery.min.js" type="text/javascript"></script>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-primary">新增</button>
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
                <tr>
                    <th scope="col">${emp.empId}</th>
                    <td>${emp.empName}</td>
                    <td>${emp.gender=="1"?"男":"女"}</td>
                    <td>${emp.email}</td>
                    <td>${emp.dId==1?"开发部":"测试部"}</td>
                    <td>
                        <button class="btn btn-primary btn-sm">
                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            编辑
                        </button>
                        <button class="btn btn-danger btn-sm">
                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            删除
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <li>
                    <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li>
                    <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>

</div>
<script type="text/javascript">
  $(function () {
      $.ajax({
          url:"/emps",
          data:"pn=1",
          type:"GET",
          success:function (result) {
              console.log(result)
              build_emps_table(result);
          }
      })
  });
  function build_emps_table(result) {
      var emp=result.list;
      $.each(emp,function (index,item) {
          var empId=$("<td></td>").append(item.empId);
          var empName=$("<td></td>").append(item.empName);
          var gender=$("<td></td>").append(item.gender==1?"男":"女");
          var email=$("<td></td>").append(item.email);
          var deptName=$("<td></td>").append(item.dId==1?"开发部":"测试部");
          $("<tr></tr>").append(empId)
              .append(empName).append(gender)
              .append(email).append(deptName).appendTo("#emp_table tbody");
      })
  }
</script>
</body>
</html>
