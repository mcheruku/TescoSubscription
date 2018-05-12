/*
	Author:		Saritha Kommineni
	Created:	29 Aug 2011
	Purpose:	Create Job for Invoking SSIS Package: RenewCustomerSubscriptions.dtsx

	--Modifications History--
	Changed On  Changed By		Defect			Description
	-------------------------------------------------------------
    11 Apr 2012  Saritha                        Added Schedule for the Job
    16 Jan 2013  Robin                          Added Switch step to the job
	29 May 2013  Robin                          Versioned the SP

*/

USE [msdb]
GO

DECLARE @job_id			binary(16),
		@schedule_id	int,
		@SQL			varchar(1000)
		

--If the job already exists, remove it.
IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE [name] = 'TescoSubscriptionRecurringPayment')
	BEGIN
	
		EXEC msdb.dbo.sp_delete_job @job_name = 'TescoSubscriptionRecurringPayment'
		
		IF NOT EXISTS(SELECT job_id FROM msdb.dbo.sysjobs_view WHERE [name] = 'TescoSubscriptionRecurringPayment')
			BEGIN
				PRINT 'SUCCESS - Job [TescoSubscriptionRecurringPayment] deleted.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job [TescoSubscriptionRecurringPayment] not deleted.',16,1)
			END
		
	END
	
--Create the new job
IF NOT EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
	BEGIN

		EXEC msdb.dbo.sp_add_job 
				@job_name='TescoSubscriptionRecurringPayment', 
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
				
		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE name = 'TescoSubscriptionRecurringPayment')
			BEGIN
				PRINT 'SUCCESS - Job [TescoSubscriptionRecurringPayment] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job [TescoSubscriptionRecurringPayment] not created.',16,1)
			END

	END

--Job Step 1
IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
BEGIN
	/****** Object:  Step [tescosubscription.CustomerSubscriptionsSwitchDueRenewal1]    Script Date: 01/16/2013 05:39:40 ******/
	EXEC msdb.dbo.sp_add_jobstep 
			@job_id=@job_Id, 
			@step_name=N'tescosubscription.CustomerSubscriptionsSwitchDueRenewal1', 
			@step_id=1, 
			@cmdexec_success_code=0, 
			@on_success_action=3, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0, @subsystem=N'TSQL', 
			@command=N'execute tescosubscription.CustomerSubscriptionsSwitchDueRenewal1', 
			@database_name=N'TescoSubscription', 
			@flags=0
		
		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id AND step_id = 1)
			BEGIN
				PRINT 'SUCCESS - Job Step [tescosubscription.CustomerSubscriptionsSwitchDueRenewal1] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job Step [tescosubscription.CustomerSubscriptionsSwitchDueRenewal1] not created.',16,1)
			END
END

--Job Step 2

IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
	BEGIN
			
		EXEC msdb.dbo.sp_add_jobstep
			@job_id=@job_id,
			@step_name=N'CustomerSubscriptionStopPaymentStatusUpdate', 
			@step_id=2, 
			@cmdexec_success_code=0, 
			@on_success_action=3, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0,
			@subsystem=N'TSQL', 
			@command=N'exec tescosubscription.CustomerSubscriptionStopStatusUpdate', 
			@database_name=N'TescoSubscription', 
			@flags=0

		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id AND step_id = 2)
			BEGIN
				PRINT 'SUCCESS - Job Step [CustomerSubscriptionStopPaymentStatusUpdate] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job Step [CustomerSubscriptionStopPaymentStatusUpdate] not created.',16,1)
			END
		
	END


--Job step 3

IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobs_view WHERE job_id = @job_id)
	BEGIN
			
		EXEC msdb.dbo.sp_add_jobstep
			@job_id=@job_id,
			@step_name=N'Call the SSIS Package', 
			@step_id=3, 
			@cmdexec_success_code=0, 
			@on_success_action=1, 
			@on_success_step_id=0, 
			@on_fail_action=2, 
			@on_fail_step_id=0, 
			@retry_attempts=0, 
			@retry_interval=0, 
			@os_run_priority=0,
			@subsystem=N'SSIS', 
			@command=N'/FILE "F:\UDL\RenewCustomerSubscriptions.dtsx" /MAXCONCURRENT " -1 " /CHECKPOINTING OFF /REPORTING E', 
			@database_name=N'master', 
			@flags=0
				
		IF EXISTS(SELECT 1 FROM msdb.dbo.sysjobsteps WHERE job_id = @job_id AND step_id = 3)
			BEGIN
				PRINT 'SUCCESS - Job Step [TescoSubscriptionRecurringPayment] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job Step [TescoSubscriptionRecurringPayment] not created.',16,1)
			END
		
	END

--Job Schedule 1 - None at this time, run ad-hoc.

IF EXISTS(SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = 'TescoSubscriptionRecurringPayment')
	BEGIN
	
		EXEC msdb.dbo.sp_add_jobschedule 
			@job_id=@job_Id,
			@name=N'Daily', 
			@enabled=1, 
			@freq_type=4, 
			@freq_interval=1, 
			@freq_subday_type=1, 
			@freq_subday_interval=0, 
			@freq_relative_interval=0, 
			@freq_recurrence_factor=0, 
			@active_start_date=20120411, 
			@active_end_date=99991231, 
			@active_start_time=003000, 
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
				PRINT 'SUCCESS - Job [TescoSubscriptionRecurringPayment] added.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Job [TescoSubscriptionRecurringPayment] not added.',16,1)
			END
		
	
	END

GO

USE [TescoSubscription]
GO