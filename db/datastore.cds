namespace ibmcap.db;

using { ibmcap.commons } from './commons';
using {  temporal, managed, Country, cuid} from '@sap/cds/common';


context master {
    // type Guid: Int16; 
    entity masha : cuid{
        characters: String(30);
    }
    
    entity student : temporal {
        key studentId: commons.Guid;
        name: String(30);
        grade: Association to one studentGrade;
        parent: String(60);
        joiningDate: Date;
        country: Country;
    }

    entity studentGrade {
        key classId: commons.Guid;
        name: String(20);
        section: Int16;
    }
}

