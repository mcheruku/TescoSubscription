IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NOT NULL
	BEGIN
	
		DROP PROCEDURE [tescosubscription].[PackageErrorLogCreate]

		IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NULL
			BEGIN
			
				PRINT 'SUCCESS - Procedure [tescosubscription].[PackageErrorLogCreate] dropped.'
				
			END
		ELSE
			BEGIN
			
				RAISERROR('FAIL - Procedure [tescosubscription].[PackageErrorLogCreate] not dropped.',16,1)
				
			END
	END
GO


CREATE PROCEDURE [tescosubscription].[PackageErrorLogCreate] 
(	  
       @ErrorID BIGINT
      ,@PackageExecutionHistoryID BIGINT
      ,@ErrorDescription VARCHAR(1000)
      ,@ErrrorDateTime DATETIME
  )

AS

/*  Author:			Saritha Kommineni
	Date created:	22 Aug 2011
	Purpose:	    To insert PackageError Log details into [tescosubscription].[PackageErrorLog] table
	Behaviour:		
	Usage:			
	Called by:		SSIS PACKAGE RenewCustomerSubscriptions.dtsx
	WarmUP Script:	Execute [tescosubscription].[PackageErrorLogCreate] 

--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
		
*/

BEGIN

	SET NOCOUNT ON;

		INSERT INTO [tescosubscription].[PackageErrorLog]
			(
             [ErrorID]
			 ,[PackageExecutionHistoryID] 
		     ,[ErrorDescription]
			 ,[ErrorDateTime]
             )            
		VALUES	
           (
              @ErrorID
              ,@PackageExecutionHistoryID
              ,@ErrorDescription  
              ,@ErrrorDateTime        		
		   )	
END

 
GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[PackageErrorLogCreate]  TO [SubsUser]

GO

--Report on the creation of the procedure.
IF OBJECT_ID(N'[tescosubscription].[PackageErrorLogCreate]',N'P') IS NOT NULL
	BEGIN
	
		PRINT 'SUCCESS - Procedure [tescosubscription].[PackageErrorLogCreate] created.'
		
	END
ELSE
	BEGIN
	
		RAISERROR('FAIL - Procedure [tescosubscription].[PackageErrorLogCreate] not created.',16,1)
		
	END
GO









