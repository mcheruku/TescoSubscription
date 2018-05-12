USE [msdb]
GO
/***************************************************************************************************

      Created By:	Robin
      Date created:	10-Oct-2013
      Purpose:		Rollback Job:  [TescoSubscriptionRecurringPayment_Notification_Notification]

      
      --Modifications History--

      Changed On   Changed By  Defect   Change Description      

****************************************************************************************************/

DECLARE @JobName varchar(255)

SET @JobName = 'TescoSubscriptionRecurringPayment_Notification' 

--If the job already exists, remove it.
IF EXISTS(SELECT job_id FROM msdb.dbo.sysjobs_view WHERE [name] = @JobName)
	BEGIN
	
		EXEC msdb.dbo.sp_delete_job @job_name = @JobName
		
		IF NOT EXISTS(SELECT job_id FROM msdb.dbo.sysjobs_view WHERE [name] = @JobName)
			BEGIN
				PRINT 'SUCCESS - Job [' + @JobName + '] deleted'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job [%s] not deleted.',16,1,@JobName)
			END
		
	END

ELSE

	BEGIN	
		PRINT 'NOT EXISTS - Job [' + @JobName + '] does not exists'
	END
GO



USE [TescoSubscription]
GO
