using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';

service MyService {
    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
    @insertonly
    entity InserEmployeeSrv as projection on master.employees;
    @updateonly
    entity UpdateEmployeeSrv as projection on master.employees;
    @deleteonly
    entity DeleteEmployeeSrv as projection on master.employees;
    function hello(name: String) returns String;
}

