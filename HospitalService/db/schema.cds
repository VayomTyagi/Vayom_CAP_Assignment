namespace hospital.management;

using { cuid, managed } from '@sap/cds/common';

// Reusable Types
type Name        : String(100);
type Phone       : String(20);
type Email       : String(255);
type Amount      : Decimal(10,2);
type MedicalNote : String(1000);

// Enums
type Gender : String enum {
    Male;
    Female;
    Other;
}

type BloodGroup : String enum {
    A_POS;
    A_NEG;
    B_POS;
    B_NEG;
    O_POS;
    O_NEG;
    AB_POS;
    AB_NEG;
}

type AppointmentStatus : String enum {
    Scheduled;
    Completed;
    Cancelled;
    NoShow;
}

// Departments
entity Departments : cuid, managed {
    name      : Name;
    floor     : Integer;
    head      : Name;
    capacity  : Integer;
    phone     : Phone;
    isActive  : Boolean default true;
}

// Doctors
entity Doctors : cuid, managed {
    firstName     : Name;
    lastName      : Name;
    specialization: String(100);
    qualification : String(100);
    experience    : Integer;
    fee           : Amount;
    department    : Association to Departments;
    phone         : Phone;
    email         : Email;
    availableDays : String(100);
    isActive      : Boolean default true;
}

// Patients
entity Patients : cuid, managed {
    firstName        : Name;
    lastName         : Name;
    dateOfBirth      : Date;
    gender           : Gender;
    bloodGroup       : BloodGroup;
    phone            : Phone;
    email            : Email;
    address          : String(255);
    emergencyContact : Phone;
    registrationDate : Date;
}

// Appointments
entity Appointments : cuid, managed {
    patient          : Association to Patients;
    doctor           : Association to Doctors;
    appointmentDate  : Date;
    appointmentTime  : Time;
    status           : AppointmentStatus default 'Scheduled';
    reason           : String(255);
    notes            : MedicalNote;
    fee              : Amount;
}

// Medical Records
entity MedicalRecords : cuid, managed {
    patient          : Association to Patients;
    doctor           : Association to Doctors;
    appointment      : Association to Appointments;
    diagnosis        : MedicalNote;
    prescription     : MedicalNote;
    testRecommended  : MedicalNote;
    recordDate       : Date;
}