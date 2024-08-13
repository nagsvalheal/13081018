/**
* @description  Used to
	create task when a video is uploaded and calling the method to
	send sms and email.
* History
* Version	Author			Date		Detail		Description
* 1.0		Niyas		24-07-2024		Created		Refactored Version
*/
public with sharing class BI_PSPB_QsqEnrolleeProcessorCtrl {
    /**
     * @description  Retrieves treatment reminders based on the given criteria.
     * @param qsqCount The type of reminder to filter by.
     * @return A list of Ids of CareProgramEnrollee objects that match the criteria.
     */
    public static List<Id> processEnrollees(Integer qsqCount) {
        List<Id> enrolleeRecIds = new List<Id>();
        try { 
            // Fetch CareProgramEnrollee objects
            List<CareProgramEnrollee> enrollees = fetchEnrollees();
            for (CareProgramEnrollee enrollee : enrollees) {
                Date enrolleeCreatedDate = enrollee.BI_PSPB_FirstLoginDate__c;
                if (enrolleeCreatedDate == System.today().addDays(-qsqCount)) {
                    enrolleeRecIds.add(enrollee.Id);
                }
            }
        } catch (Exception ex) {
            BI_PSP_LogMessagesUtility.exceptionLogMessage(
          		ex.getMessage(),
          		BI_PSPB_QsqQuestionnaireServiceCtrl.class.getName(),
          		ex
        	);
        }
        return enrolleeRecIds;
    }
    
    /**
     * @description  Fetches CareProgramEnrollee records.
     * @return A list of CareProgramEnrollee objects.
     */
    public static List<CareProgramEnrollee> fetchEnrollees() {
        List<CareProgramEnrollee> enrolleeRecords = new List<CareProgramEnrollee>();
        try {
            // Query CareProgramEnrollee objects
            String fields = 'Id, BI_PSPB_FirstLoginDate__c';
			enrolleeRecords = BI_PSP_CommonQueryUtility.executeQuery(
			'CareProgramEnrollee',
			fields,
			null,
			false
		);
        } catch (Exception ex) {
            BI_PSP_LogMessagesUtility.exceptionLogMessage(
                ex.getMessage(),
                BI_PSPB_QsqQuestionnaireServiceCtrl.class.getName(),
                ex
            );
        }
        return enrolleeRecords;
    }
}