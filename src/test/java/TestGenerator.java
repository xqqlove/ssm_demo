import com.yiwa.bean.Department;
import com.yiwa.bean.Employee;
import com.yiwa.dao.DepartmentMapper;
import com.yiwa.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestGenerator {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSession sqlSession;
//    @Test
//    public void test() throws Exception {
//        List<String> warnings = new ArrayList<String>();
//        boolean overwrite = true;
//        File configFile = new File("mybatis-generator-config.xml");
//        ConfigurationParser cp = new ConfigurationParser(warnings);
//        Configuration config = cp.parseConfiguration(configFile);
//        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
//        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
//        myBatisGenerator.generate(null);
//    }

    @Test
    public void test1() {
//        ApplicationContext ioc=new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
//        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
//        System.out.println(bean);
        System.out.println(departmentMapper);
        Department department=new Department();
//        department.setDeptName("开发部");
//        department.setDeptName("测试部");
//        departmentMapper.insertSelective(department);
//        Employee record=new Employee();
//        record.setEmail("jerry@com");
//        record.setEmpName("jerry");
//        record.setGender("2");
//        record.setdId(2);
//        employeeMapper.insertSelective(record);

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++){
            String uid= UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid,"1",uid+"@yiwa.com",1));
        }
    }
}
