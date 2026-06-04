using {com.hr.views as dbv} from '../db/views';

service HRView{
    @readonly entity TeamOverview      as projection on dbv.TeamOverview;
    @readonly entity ProjectDashboard  as projection on dbv.ProjectDashboard;
    @readonly entity SkillsMatrix      as projection on dbv.SkillsMatrix;
}