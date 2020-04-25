package com.yiwa.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yiwa.bean.Employee;
import com.yiwa.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/emps")
    @ResponseBody
    public PageInfo getEmps(@RequestParam(value = "pn" ,defaultValue = "1") Integer pn,
                          Model model ){
        PageHelper.startPage(pn,5);
        List<Employee> all = employeeService.getAll();
        PageInfo pageInfo=new PageInfo(all,5);
        return pageInfo;
    }
}
