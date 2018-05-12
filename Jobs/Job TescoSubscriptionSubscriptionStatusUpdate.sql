/*
	Author:		Saritha Kommineni
	Created:	25 Mar 2014
	Purpose:	Create Job for Calling SP: tescosubscription.SuspendedToCancelledStatusUpdate 
	--Modifications History--
	Changed On         Changed By		  Defect			   Description
	------------     --------------     -----------     ------------------
 
       

*/

USE [msdb]
GO

DECLARE @job_id			binary(16),
		@schedule_id	int
	
		

--If the job already exists, remove it.
IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE [name] = 'TescoSubscriptionSubscriptionStatusUpdate')
	BEGIN
	
		EXEC msdb.dbo.sp_delete_job @job_name = 'TescoSubscriptionSubscriptionStatusUpdate'
		
		IF NOT EXISTS(SELECT job_id FROM msdb.dbo.sysjobs_view WHERE [name] = 'TescoSubscriptionSubscriptionStatusUpdate')
			BEGIN
				PRINT 'SUCCESS - Job TescoSubscriptionSubscriptionStatusUpdate deleted.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job TescoSubscriptionSubscriptionStatusUpdate not deleted.',16,1)
			END
		
	END
	
--Create the new job
IF NOT EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
	BEGIN

		EXEC msdb.dbo.sp_add_job 
				@job_name='TescoSubscriptionSubscriptionStatusUpdate', 
				@enabled=1, 
				@notify_level_eventlog=0, 
				@notify_level_email=0, 
				@notify_level_netsend=0, 
				@notify_level_page=0, 
				@delete_level=0, 
				@description=N'Shceduled Job', 
				@category_name=N'[Uncategorized (Local)]', 
				@owner_login_name=N'sa', 
				@job_id=@job_id OUTPUT
				
		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE name = 'TescoSubscriptionSubscriptionStatusUpdate')
			BEGIN
				PRINT 'SUCCESS - Job TescoSubscriptionSubscriptionStatusUpdate created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job TescoSubscriptionSubscriptionStatusUpdate not created.',16,1)
			END

	END

--Job Step 1

IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
	BEGIN


			
		EXEC msdb.dbo.sp_add_jobstep
			@job_id=@job_id,
			@step_name=N'Call SP SuspendedToCancelledStatusUpdate', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0,
			@subsystem=N'TSQL', 
			@command=N'EXEC tescosubscription.SuspendedToCancelledStatusUpdate',  
			@database_name=N'TescoSubscription', 
			@flags=0
				

IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id AND step_id = 1)
			BEGIN
				PRINT 'SUCCESS - Job Step TescoSubscriptionSubscriptionStatusUpdate created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job Step TescoSubscriptionSubscriptionStatusUpdate not created.',16,1)
			END
		
	END



--Job Schedule 

IF EXISTS(SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = 'TescoSubscriptionSubscriptionStatusUpdate')
	BEGIN
	
		EXEC msdb.dbo.sp_add_jobschedule 
			@job_id=@job_Id,
			@name=N'Monthly', 
			@enabled=1, 
			@freq_type=16, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=1, 
			@active_start_date=20140425, 
			@active_end_date=99991231, 
			@active_start_time=0, 
			@active_end_time=235959
	
		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobschedules WHERE job_id = @job_id)
			BEGIN
				PRINT 'SUCCESS - Schedule created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Schedule  not created.',16,1)
			END	
	
	END


--Job Server
IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
	BEGIN
	
		EXEC msdb.dbo.sp_add_jobserver @job_id = @job_id, @server_name = N'(local)'
		
		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobservers WHERE job_id = @job_id)
			BEGIN
				PRINT 'SUCCESS - Job TescoSubscriptionSubscriptionStatusUpdate added.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job TescoSubscriptionSubscriptionStatusUpdate not added.',16,1)
			END
		
	
	END

GO

USE [TescoSubscription]
GO