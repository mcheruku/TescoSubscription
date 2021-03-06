IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PackageExecutionHistoryUpdate]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] not dropped.',16,1)
				
			END
	END
GO



CREATE PROCEDURE [tescosubscription].[PackageExecutionHistoryUpdate] 
(	   
        @PackageExecutionHistoryID  BIGINT
       ,@PackageEndtime DATETIME
       ,@statusID TINYINT
)

AS

/*  Author:			Saritha Kommineni
	Date created:	22 Aug 2011
	Purpose:	    To update PackageExecution details into [tescosubscription].[PackageExecutionHistory] table
	Behaviour:		
	Usage:			
	Called by:		
	WarmUP Script:	Execute [tescosubscription].[PackageExecutionHistoryUpdate]  

--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	
*/

BEGIN
SET NOCOUNT ON;

		Update  [tescosubscription].[PackageExecutionHistory]          
		set [PackageEndTime]= @PackageEndtime,
			[statusID] = @statusID
		where PackageExecutionHistoryID = @PackageExecutionHistoryID 

END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PackageExecutionHistoryUpdate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistoryUpdate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PackageExecutionHistoryUpdate] not created.',16,1)
		
	END
GO



