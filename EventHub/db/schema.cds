namespace platform.events;

using { cuid, managed } from '@sap/cds/common';

// ─── Reusable Types ────────────────────────────────────────────────────────────

type Email   : String(255);
type Phone   : String(20);
type Amount  : Decimal(10, 2);
type Rating  : Integer;
type Name    : String(100);
type URL     : String(500);

// ─── Enumerations ─────────────────────────────────────────────────────────────

type EventType : String(20) enum {
    Conference  = 'Conference';
    Workshop    = 'Workshop';
    Seminar     = 'Seminar';
    Webinar     = 'Webinar';
    Meetup      = 'Meetup';
}

type EventStatus : String(20) enum {
    Draft       = 'Draft';
    Published   = 'Published';
    Ongoing     = 'Ongoing';
    Completed   = 'Completed';
    Cancelled   = 'Cancelled';
}

type TicketType : String(20) enum {
    General     = 'General';
    VIP         = 'VIP';
    Student     = 'Student';
}

type RegistrationStatus : String(20) enum {
    Confirmed   = 'Confirmed';
    Cancelled   = 'Cancelled';
    Waitlisted  = 'Waitlisted';
    Attended    = 'Attended';
}

type VenueType : String(20) enum {
    Auditorium      = 'Auditorium';
    ConferenceHall  = 'ConferenceHall';
    Outdoor         = 'Outdoor';
    Virtual         = 'Virtual';
}

// ─── Entities ─────────────────────────────────────────────────────────────────

entity Venues : cuid, managed {
    name          : Name          @mandatory;
    address       : String(300)   @mandatory;
    city          : String(100)   @mandatory;
    capacity      : Integer       @mandatory;
    type          : VenueType     @mandatory;
    amenities     : String(500);   // comma-separated
    hourlyRate    : Amount;
    contactPerson : Name;
    phone         : Phone;
    isActive      : Boolean default true;

    // Reverse association
    events        : Association to many Events on events.venue = $self;
}

entity Events : cuid, managed {
    title            : String(200)  @mandatory;
    description      : String(2000);
    eventType        : EventType    @mandatory;
    venue            : Association to Venues;
    startDate        : Date         @mandatory;
    endDate          : Date         @mandatory;
    startTime        : Time;
    endTime          : Time;
    maxAttendees     : Integer;
    registeredCount  : Integer      default 0;
    ticketPrice      : Amount;
    status           : EventStatus  default 'Draft';
    organizerName    : Name;
    organizerEmail   : Email;
    tags             : String(500);  // comma-separated

    // Associations
    speakers         : Composition of many EventSpeakers on speakers.event = $self;
    registrations    : Composition of many Registrations on registrations.event = $self;
    feedbacks        : Composition of many Feedback on feedbacks.event = $self;
}

entity Speakers : cuid, managed {
    name        : Name    @mandatory;
    email       : Email   @mandatory;
    phone       : Phone;
    bio         : String(2000);
    company     : String(150);
    designation : String(150);
    expertise   : String(500);
    photoUrl    : URL;
    rating      : Rating  default 0;
    totalTalks  : Integer default 0;
    isActive    : Boolean default true;
}

// Composite key: one speaker per event assignment
entity EventSpeakers {
    key event           : Association to Events;
    key speaker         : Association to Speakers;
    topic           : String(300);
    sessionTime     : Time;
    sessionDuration : Integer;   // minutes
    roomNumber      : String(20);
}

entity Registrations : cuid, managed {
    event           : Association to Events  @mandatory;
    attendeeName    : Name                   @mandatory;
    attendeeEmail   : Email                  @mandatory;
    attendeePhone   : Phone;
    company         : String(150);
    ticketType      : TicketType  default 'General';
    registrationDate: DateTime;
    status          : RegistrationStatus default 'Confirmed';
    amountPaid      : Amount;
    paymentId       : String(100);
}

entity Feedback : cuid, managed {
    event          : Association to Events  @mandatory;
    attendeeEmail  : Email                  @mandatory;
    overallRating  : Rating;
    contentRating  : Rating;
    venueRating    : Rating;
    speakerRating  : Rating;
    comment        : String(2000);
    submittedAt    : DateTime;
}
