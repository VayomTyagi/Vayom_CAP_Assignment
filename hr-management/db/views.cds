namespace com.hr.views;
using {com.hr.Employees , com.hr.Departments, com.hr.Projects, com.hr.Assignments, com.hr.EmployeeSkills} from './schema';

// ═══════════════════════════════════════════════════
// TEAM OVERVIEW
// Active employees with department information
// ═════════════════════════════════════════════════──

entity TeamOverview as select from Employees {
    ID,
    firstName,
    lastName,
    email,
    phone,
    jobTitle,
    hireDate,
    salary,
    isActive,
    department.deptName as departmentName
}where isActive = true;


// ═══════════════════════════════════════════════════
// PROJECT DASHBOARD
// Project summary with manager details
// ═══════════════════════════════════════════════════

entity ProjectDashboard as select from Projects {
    ID,
    projectName,
    description,
    startDate,
    endDate,
    budget,
    status,
    manager.firstName as managerFirstName,
    manager.lastName  as managerLastName
}where status != 'Cancelled';


// ═══════════════════════════════════════════════════
// SKILLS MATRIX
// Employee skill inventory
// ═══════════════════════════════════════════════════

entity SkillsMatrix as select from EmployeeSkills {
    employee.ID          as employeeID,
    employee.firstName   as firstName,
    employee.lastName    as lastName,
    employee.jobTitle    as jobTitle,
    skill.ID             as skillID,
    skill.skillName      as skillName,
    skill.category       as skillCategory,
    proficiency,
    yearsOfExperience,
    certifiedDate
};


// ═══════════════════════════════════════════════════
// DEPARTMENT SUMMARY
// Department with head and employee count
// ═══════════════════════════════════════════════════

entity DepartmentSummary as select from Departments {
    ID,
    deptName,
    location,
    budget,
    head.firstName as headFirstName,
    head.lastName  as headLastName
};


// ═══════════════════════════════════════════════════
// EMPLOYEE PROJECTS
// Shows who is working on which project
// ═══════════════════════════════════════════════════

entity EmployeeProjects as select from Assignments {
    employee.firstName as firstName,
    employee.lastName  as lastName,
    project.projectName as projectName,
    role,
    allocation,
    startDate,
    endDate
};


// ═══════════════════════════════════════════════════
// PROJECT RESOURCE ALLOCATION
// Resource planning view
// ═══════════════════════════════════════════════════

entity ProjectResources as select from Assignments {
    project.projectName as projectName,
    employee.firstName as firstName,
    employee.lastName  as lastName,
    role,
    allocation
};