namespace edu.university;

using { cuid, managed } from '@sap/cds/common';

// =====================
// Reusable Types
// =====================

type Email       : String(255);
type Phone       : String(20);
type Percentage  : Decimal(5,2);
type GradePoint  : Decimal(3,2);
type Semester    : Integer;

// =====================
// Enums
// =====================

type Designation : String enum {
    Assistant;
    Associate;
    Full;
    Distinguished;
}

type EnrollmentStatus : String enum {
    Enrolled;
    Dropped;
    Completed;
}

type Grade : String enum {
    A;
    B;
    C;
    D;
    F;
}

type ExamType : String enum {
    Midterm;
    Final;
    Quiz;
    Assignment;
}

// =====================
// Departments
// =====================

entity Departments {

    key code           : String(10);

    name               : String(100);
    building           : String(100);
    headProfessor      : String(100);
    establishedYear    : Integer;
}

// =====================
// Professors
// =====================

entity Professors : cuid, managed {

    firstName          : String(50);
    lastName           : String(50);

    email              : Email;
    phone              : Phone;

    departmentCode     : Association to Departments;

    designation        : Designation;

    joinDate           : Date;
    salary             : Decimal(12,2);

    officeRoom         : String(30);
}

// =====================
// Courses
// =====================

entity Courses {

    key code           : String(20);

    title              : String(150);
    description        : String(500);

    credits            : Integer;

    maxStudents        : Integer;

    currentEnrolled    : Integer default 0;

    semester           : Semester;

    departmentCode     : Association to Departments;

    professorId        : Association to Professors;

    schedule           : String(100);

    roomNumber         : String(30);

    isActive           : Boolean default true;
}

// =====================
// Students
// =====================

entity Students : cuid, managed {

    rollNumber         : String(20) @assert.unique;

    firstName          : String(50);
    lastName           : String(50);

    email              : Email;
    phone              : Phone;

    dateOfBirth        : Date;

    admissionYear      : Integer;

    currentSemester    : Semester;

    cgpa               : Decimal(3,2);

    departmentCode     : Association to Departments;

    isActive           : Boolean default true;
}

// =====================
// Enrollments
// =====================

entity Enrollments {

    key studentId      : Association to Students;

    key courseCode     : Association to Courses;

    enrollmentDate     : Date;

    status             : EnrollmentStatus default 'Enrolled';

    grade              : Grade;

    gradePoints        : GradePoint;

    attendancePercent  : Percentage;
}

// =====================
// Exams
// =====================

entity Exams : cuid, managed {

    courseCode         : Association to Courses;

    examType           : ExamType;

    date               : Date;

    maxMarks           : Integer;

    weightagePercent   : Percentage;
}