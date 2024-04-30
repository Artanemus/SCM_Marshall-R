object SCM: TSCM
  OnCreate = DataModuleCreate
  Height = 607
  Width = 438
  object scmConnection: TFDConnection
    Params.Strings = (
      'ConnectionDef=MSSQL_SwimClubMeet'
      'LoginTimeout=0')
    ConnectedStoredUsage = [auDesignTime]
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 24
  end
  object tblSwimClub: TFDTable
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SwimClubID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayNumeric]
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    UpdateOptions.UpdateTableName = 'SwimClubMeet..SwimClub'
    UpdateOptions.KeyFields = 'SwimClubID'
    TableName = 'SwimClubMeet..SwimClub'
    Left = 48
    Top = 120
    object tblSwimClubSwimClubID: TFDAutoIncField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object tblSwimClubCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object tblSwimClubNickName: TWideStringField
      FieldName = 'NickName'
      Origin = 'NickName'
      Size = 128
    end
    object tblSwimClubEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Size = 128
    end
    object tblSwimClubContactNum: TWideStringField
      FieldName = 'ContactNum'
      Size = 30
    end
    object tblSwimClubWebSite: TWideStringField
      FieldName = 'WebSite'
      Origin = 'WebSite'
      Size = 256
    end
    object tblSwimClubHeatAlgorithm: TIntegerField
      FieldName = 'HeatAlgorithm'
    end
    object tblSwimClubEnableTeamEvents: TBooleanField
      FieldName = 'EnableTeamEvents'
    end
    object tblSwimClubEnableSwimOThon: TBooleanField
      FieldName = 'EnableSwimOThon'
    end
    object tblSwimClubEnableExtHeatTypes: TBooleanField
      FieldName = 'EnableExtHeatTypes'
    end
    object tblSwimClubNumOfLanes: TIntegerField
      FieldName = 'NumOfLanes'
    end
    object tblSwimClubEnableMembershipStr: TBooleanField
      FieldName = 'EnableMembershipStr'
    end
    object tblSwimClubLenOfPool: TIntegerField
      FieldName = 'LenOfPool'
    end
  end
  object dsSwimClub: TDataSource
    DataSet = tblSwimClub
    Left = 112
    Top = 120
  end
  object dsSession: TDataSource
    DataSet = qrySession
    Left = 112
    Top = 264
  end
  object dsEvent: TDataSource
    DataSet = qryEvent
    Left = 112
    Top = 320
  end
  object dsHeat: TDataSource
    DataSet = qryHeat
    Left = 112
    Top = 378
  end
  object dsMember: TDataSource
    DataSet = qryMember
    Left = 112
    Top = 200
  end
  object qryEntrant: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'EntrantID;HeatID'
    MasterSource = dsLane
    MasterFields = 'EntrantID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEInsert, uvCheckRequired]
    UpdateOptions.EnableInsert = False
    UpdateOptions.CheckRequired = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Entrant'
    UpdateOptions.KeyFields = 'EntrantID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'SELECT Entrant.EntrantID'
      '    , Entrant.HeatID'
      '    , HeatIndividual.HeatNum'
      '    , Entrant.Lane'
      '    , Entrant.RaceTime'
      '    , Entrant.TimeToBeat'
      '    , Entrant.IsDisqualified'
      '    , Entrant.IsScratched'
      '    , Entrant.PersonalBest'
      '    , dbo.SwimTimeToString(Entrant.TimeToBeat) AS TimeToBetStr'
      
        '    , dbo.SwimTimeToString(Entrant.PersonalBest) AS PersonalBest' +
        'Str'
      '    , dbo.SwimTimeToString(Entrant.RaceTime) AS RaceTimeStr'
      '    , CONCAT ('
      '        Member.FirstName'
      '        , '#39' '#39
      '        , Upper(Member.LastName)'
      '        ) AS FNameStr'
      ''
      #9',CASE '
      #9#9'WHEN Entrant.IsDisqualified = 1 THEN '#39'DISQUALIFIED'#39
      #9#9'WHEN Entrant.IsScratched = 1 THEN '#39'SCRATCHED'#39' '
      #9#9'ELSE '#39'QUALIFIED'#39
      #9#9'END'
      #9#9#9'as QualifiedStatus'
      ''
      '    , CONCAT ('
      '         FORMAT(HeatIndividual.HeatNum, '#39'\Heat\ #0\  '#39')'
      '        ,FORMAT(Entrant.Lane, '#39'\Lane\ #0\ '#39')'
      '        , '#39' '#39
      '        , Member.FirstName'
      '        , '#39' '#39
      '        , Upper(Member.LastName)'
      '        ) AS HeatNumLaneFNameStr'
      '        '
      '    , Upper(Member.LastName) AS LastNameStr'
      '    '
      'FROM Entrant'
      'INNER JOIN HeatIndividual'
      '    ON Entrant.HeatID = HeatIndividual.HeatID'
      'LEFT OUTER JOIN Member'
      '    ON Entrant.MemberID = Member.MemberID'
      'ORDER BY Entrant.Lane')
    Left = 40
    Top = 506
    object qryEntrantEntrantID: TFDAutoIncField
      FieldName = 'EntrantID'
      Origin = 'EntrantID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryEntrantHeatID: TIntegerField
      FieldName = 'HeatID'
      Origin = 'HeatID'
    end
    object qryEntrantHeatNum: TIntegerField
      FieldName = 'HeatNum'
      Origin = 'HeatNum'
    end
    object qryEntrantLane: TIntegerField
      FieldName = 'Lane'
      Origin = 'Lane'
    end
    object qryEntrantRaceTime: TTimeField
      FieldName = 'RaceTime'
      Origin = 'RaceTime'
    end
    object qryEntrantTimeToBeat: TTimeField
      FieldName = 'TimeToBeat'
      Origin = 'TimeToBeat'
    end
    object qryEntrantIsDisqualified: TBooleanField
      FieldName = 'IsDisqualified'
      Origin = 'IsDisqualified'
      Required = True
    end
    object qryEntrantIsScratched: TBooleanField
      FieldName = 'IsScratched'
      Origin = 'IsScratched'
      Required = True
    end
    object qryEntrantPersonalBest: TTimeField
      FieldName = 'PersonalBest'
      Origin = 'PersonalBest'
    end
    object qryEntrantTimeToBetStr: TWideStringField
      FieldName = 'TimeToBetStr'
      Origin = 'TimeToBetStr'
      ReadOnly = True
      Size = 12
    end
    object qryEntrantPersonalBestStr: TWideStringField
      FieldName = 'PersonalBestStr'
      Origin = 'PersonalBestStr'
      ReadOnly = True
      Size = 12
    end
    object qryEntrantRaceTimeStr: TWideStringField
      FieldName = 'RaceTimeStr'
      Origin = 'RaceTimeStr'
      ReadOnly = True
      Size = 12
    end
    object qryEntrantFNameStr: TWideStringField
      FieldName = 'FNameStr'
      Origin = 'FNameStr'
      ReadOnly = True
      Required = True
      Size = 257
    end
    object qryEntrantQualifiedStatus: TStringField
      FieldName = 'QualifiedStatus'
      Origin = 'QualifiedStatus'
      ReadOnly = True
      Required = True
      Size = 12
    end
    object qryEntrantHeatNumLaneFNameStr: TWideStringField
      FieldName = 'HeatNumLaneFNameStr'
      Origin = 'HeatNumLaneFNameStr'
      ReadOnly = True
      Required = True
      Size = 4000
    end
    object qryEntrantLastNameStr: TWideStringField
      FieldName = 'LastNameStr'
      Origin = 'LastNameStr'
      ReadOnly = True
      Size = 128
    end
  end
  object dsEntrant: TDataSource
    DataSet = qryEntrant
    Left = 112
    Top = 506
  end
  object qrySession: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Active = True
    IndexFieldNames = 'SwimClubID'
    MasterSource = dsSwimClub
    MasterFields = 'SwimClubID'
    Connection = scmConnection
    FormatOptions.AssignedValues = [fvFmtDisplayDateTime]
    FormatOptions.FmtDisplayDateTime = 'dddd dd/mm/yyyy HH:nn'
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Session'
    UpdateOptions.KeyFields = 'SessionID'
    SQL.Strings = (
      'DECLARE @HideClosed AS BIT;'
      'SET @HideClosed = :HIDECLOSED;'
      ''
      'SELECT Session.SessionID'
      '     , Session.SessionStart'
      '     , Session.SwimClubID'
      '     , Session.SessionStatusID'
      '     , CASE'
      '           WHEN Session.SessionStatusID = 1 THEN'
      '               '#39'(UNLOCKED)'#39
      '           ELSE'
      '               '#39'(LOCKED)'#39
      '       END AS SessionStatusStr'
      '     , Session.Caption'
      
        '     , FORMAT(SessionStart, '#39'dddd dd/MM/yyyy HH:mm'#39') AS SessionS' +
        'tartStr'
      '     , CONCAT('
      '                 FORMAT(SessionStart, '#39'yyyy-MM-dd HH:mm'#39')'
      
        '               , IIF(Session.SessionStatusID = 1, '#39' '#39', '#39' (LOCKED' +
        ') '#39')'
      '               , [Session].Caption'
      '             ) AS SessionDetailStr'
      'FROM Session'
      ''
      
        '-- WHERE (Session.SessionStatusID = 1) OR Session.SessionStatusI' +
        'D = CASE WHEN @HideClosed=1 THEN 1 ELSE 2 END'
      'WHERE ('
      '          @HideClosed = 0'
      '          AND Session.SessionStatusID = 2'
      '      )'
      '      OR (Session.SessionStatusID = 1)'
      'ORDER BY Session.SessionStart DESC'
      ''
      '')
    Left = 48
    Top = 264
    ParamData = <
      item
        Name = 'HIDECLOSED'
        DataType = ftBoolean
        ParamType = ptInput
        Value = True
      end>
    object qrySessionSessionID: TFDAutoIncField
      FieldName = 'SessionID'
      Origin = 'SessionID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qrySessionSessionStart: TSQLTimeStampField
      FieldName = 'SessionStart'
      Origin = 'SessionStart'
      DisplayFormat = 'dddd dd/mm/yyyy HH:nn'
    end
    object qrySessionSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
    end
    object qrySessionSessionStatusID: TIntegerField
      FieldName = 'SessionStatusID'
      Origin = 'SessionStatusID'
    end
    object qrySessionSessionStatusStr: TStringField
      FieldName = 'SessionStatusStr'
      Origin = 'SessionStatusStr'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object qrySessionCaption: TWideStringField
      FieldName = 'Caption'
      Origin = 'Caption'
      Size = 128
    end
    object qrySessionSessionStartStr: TWideStringField
      FieldName = 'SessionStartStr'
      Origin = 'SessionStartStr'
      ReadOnly = True
      Size = 4000
    end
    object qrySessionSessionDetailStr: TWideStringField
      FieldName = 'SessionDetailStr'
      Origin = 'SessionDetailStr'
      ReadOnly = True
      Required = True
      Size = 4000
    end
  end
  object qryHeat: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    AfterScroll = qryHeatAfterScroll
    IndexFieldNames = 'EventID'
    MasterSource = dsEvent
    MasterFields = 'EventID'
    DetailFields = 'EventID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..HeatIndividual'
    UpdateOptions.KeyFields = 'HeatID'
    SQL.Strings = (
      'SELECT HeatIndividual.HeatID'
      '     , HeatIndividual.HeatNum'
      '     , HeatIndividual.EventID'
      '     , HeatIndividual.HeatTypeID'
      '     , HeatIndividual.HeatStatusID'
      '     , HeatStatus.Caption AS StatusStr'
      '     , CONCAT('#39'Heat: '#39', HeatIndividual.HeatNum) AS HeatNumStr1'
      '     , CONCAT(   '#39'Heat: '#39
      '               , HeatIndividual.HeatNum'
      '               , CASE'
      '                     WHEN HeatIndividual.HeatStatusID = 1 THEN'
      '                         '#39#39
      '                     ELSE'
      '                         '#39' (CLOSED)'#39
      '                 END'
      '             ) AS HeatNumStr2'
      'FROM HeatIndividual'
      '    INNER JOIN HeatStatus'
      '        ON HeatIndividual.HeatStatusID = HeatStatus.HeatStatusID'
      'ORDER BY HeatIndividual.HeatNum')
    Left = 48
    Top = 378
    object qryHeatHeatID: TFDAutoIncField
      FieldName = 'HeatID'
      Origin = 'HeatID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryHeatHeatNum: TIntegerField
      FieldName = 'HeatNum'
      Origin = 'HeatNum'
    end
    object qryHeatEventID: TIntegerField
      FieldName = 'EventID'
      Origin = 'EventID'
    end
    object qryHeatHeatTypeID: TIntegerField
      FieldName = 'HeatTypeID'
      Origin = 'HeatTypeID'
    end
    object qryHeatHeatStatusID: TIntegerField
      FieldName = 'HeatStatusID'
      Origin = 'HeatStatusID'
    end
    object qryHeatStatusStr: TWideStringField
      FieldName = 'StatusStr'
      Origin = 'StatusStr'
      Size = 60
    end
    object qryHeatHeatNumStr1: TStringField
      FieldName = 'HeatNumStr1'
      Origin = 'HeatNumStr1'
      ReadOnly = True
      Required = True
      Size = 18
    end
    object qryHeatHeatNumStr2: TStringField
      FieldName = 'HeatNumStr2'
      Origin = 'HeatNumStr2'
      ReadOnly = True
      Required = True
      Size = 27
    end
  end
  object qryEvent: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'SessionID'
    MasterSource = dsSession
    MasterFields = 'SessionID'
    DetailFields = 'SessionID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Event'
    UpdateOptions.KeyFields = 'EventID'
    SQL.Strings = (
      'USE SwimClubMeet'
      ''
      'SELECT Event.EventID'
      '    , Event.EventNum'
      '    , qryNominees.NomineeCount'
      '    , qryEntrants.EntrantCount'
      '    , Event.SessionID'
      '    , Event.StrokeID'
      '    , Event.DistanceID'
      '    , Event.EventStatusID'
      '    , CONCAT ('
      '        '#39'#'#39
      '        , Format([EventNum], '#39'0#'#39')'
      '        , '#39' - '#39
      '        , Distance.Caption'
      '        , '#39' '#39
      '        , Stroke.Caption'
      ', '#39'. '#39
      ', Event.Caption'
      '        ) AS ListTextStr'
      '    , CONCAT ('
      '        '#39'Event '#39
      '        , Event.EventNum'
      '        , '#39' - '#39
      '        , Distance.Caption'
      '        , '#39' '#39
      '        , Stroke.Caption'
      '        , '#39' (NOM:'#39
      '        , NomineeCount'
      '        , '#39' ENT:'#39
      '        , EntrantCount'
      '        , '#39')'#39
      '        ) AS ListDetailStr'
      ''
      'FROM Event'
      'LEFT OUTER JOIN Stroke'
      '    ON Stroke.StrokeID = Event.StrokeID'
      'LEFT OUTER JOIN Distance'
      '    ON Distance.DistanceID = Event.DistanceID'
      'LEFT OUTER JOIN EventStatus'
      '    ON EventStatus.EventStatusID = Event.EventStatusID'
      'LEFT JOIN ('
      '    SELECT Count(Nominee.EventID) AS NomineeCount'
      '        , EventID'
      '    FROM Nominee'
      '    GROUP BY Nominee.EventID'
      '    ) qryNominees'
      '    ON qryNominees.EventID = Event.EventID'
      'LEFT JOIN ('
      '    SELECT Count(Entrant.EntrantID) AS EntrantCount'
      '        , HeatIndividual.EventID'
      '    FROM Entrant'
      '    INNER JOIN HeatIndividual'
      '        ON Entrant.HeatID = HeatIndividual.HeatID'
      '    WHERE (Entrant.MemberID IS NOT NULL)'
      '    GROUP BY HeatIndividual.EventID'
      '    ) qryEntrants'
      '    ON qryEntrants.EventID = Event.EventID'
      'ORDER BY Event.EventNum;')
    Left = 48
    Top = 320
    object qryEventEventID: TFDAutoIncField
      FieldName = 'EventID'
      Origin = 'EventID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryEventEventNum: TIntegerField
      FieldName = 'EventNum'
      Origin = 'EventNum'
    end
    object qryEventNomineeCount: TIntegerField
      FieldName = 'NomineeCount'
      Origin = 'NomineeCount'
      ReadOnly = True
    end
    object qryEventEntrantCount: TIntegerField
      FieldName = 'EntrantCount'
      Origin = 'EntrantCount'
      ReadOnly = True
    end
    object qryEventSessionID: TIntegerField
      FieldName = 'SessionID'
      Origin = 'SessionID'
    end
    object qryEventStrokeID: TIntegerField
      FieldName = 'StrokeID'
      Origin = 'StrokeID'
    end
    object qryEventDistanceID: TIntegerField
      FieldName = 'DistanceID'
      Origin = 'DistanceID'
    end
    object qryEventEventStatusID: TIntegerField
      FieldName = 'EventStatusID'
      Origin = 'EventStatusID'
    end
    object qryEventListTextStr: TWideStringField
      FieldName = 'ListTextStr'
      Origin = 'ListTextStr'
      ReadOnly = True
      Required = True
      Size = 4000
    end
    object qryEventListDetailStr: TWideStringField
      FieldName = 'ListDetailStr'
      Origin = 'ListDetailStr'
      ReadOnly = True
      Required = True
      Size = 314
    end
  end
  object qryMember: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'MemberID'
    Connection = scmConnection
    UpdateOptions.UpdateTableName = 'SwimClubMeet..Member'
    UpdateOptions.KeyFields = 'MemberID'
    SQL.Strings = (
      'SELECT '
      '[MemberID]'
      '      ,[MembershipNum]'
      '      ,[MembershipStr]'
      '      ,[FirstName]'
      '      ,[LastName]'
      '      ,[DOB]'
      '      ,[IsActive]'
      '      ,[Email]'
      '      ,[EnableEmailOut]'
      '      ,[GenderID]'
      '      ,[SwimClubID]'
      
        ',SubString(Concat(Member.FirstName, '#39' '#39', Upper(Member.LastName))' +
        ', 0, 60) AS FName'
      ''
      'FROM Member ORDER BY [LastName]')
    Left = 48
    Top = 200
    object qryMemberMemberID: TFDAutoIncField
      FieldName = 'MemberID'
      Origin = 'MemberID'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryMemberMembershipNum: TIntegerField
      FieldName = 'MembershipNum'
      Origin = 'MembershipNum'
    end
    object qryMemberMembershipStr: TWideStringField
      FieldName = 'MembershipStr'
      Origin = 'MembershipStr'
      Size = 24
    end
    object qryMemberFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Size = 128
    end
    object qryMemberLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Size = 128
    end
    object qryMemberDOB: TSQLTimeStampField
      FieldName = 'DOB'
      Origin = 'DOB'
    end
    object qryMemberIsActive: TBooleanField
      FieldName = 'IsActive'
      Origin = 'IsActive'
      Required = True
    end
    object qryMemberEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'Email'
      Size = 256
    end
    object qryMemberEnableEmailOut: TBooleanField
      FieldName = 'EnableEmailOut'
      Origin = 'EnableEmailOut'
      Required = True
    end
    object qryMemberGenderID: TIntegerField
      FieldName = 'GenderID'
      Origin = 'GenderID'
    end
    object qryMemberSwimClubID: TIntegerField
      FieldName = 'SwimClubID'
      Origin = 'SwimClubID'
    end
    object qryMemberFName: TWideStringField
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Size = 60
    end
  end
  object qryLane: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'LaneNum;EntrantID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.KeyFields = 'LaneID'
    SQL.Strings = (
      '-- Create a new table called '#39'[#Lanes]'#39' in schema '#39'[dbo]'#39
      '-- Drop the table if it already exists'
      'IF OBJECT_ID('#39'[dbo].[#Lanes]'#39', '#39'U'#39') IS NOT NULL'
      'DROP TABLE [dbo].[#Lanes]'
      ';'
      ''
      '-- Create the table in the specified schema'
      'CREATE TABLE [dbo].[#Lanes]'
      '('
      '    [LaneID] INT NOT NULL PRIMARY KEY, -- Primary Key column'
      '    [LaneNum] int NOT NULL,'
      '    [LaneStr] NVARCHAR(50) NOT NULL,'
      '    [HeatID] int NULL,'
      ');'
      ''
      ''
      'DECLARE @MaxNumOfLanes AS INT;'
      'DECLARE @i AS INT;'
      'DECLARE @HEATID AS INT;'
      ''
      
        'SET @MaxNumOfLanes = (SELECT NumOfLanes FROM SwimClub WHERE Swim' +
        'Club.SwimClubID = 1);'
      'IF @MaxNumOfLanes = NULL SET @MaxNumOfLanes = 8;'
      'SET @i = 1;'
      'SET @HEATID = :HEATID;'
      '-- IF @HEATID = 0 SET @HEATID = NULL;'
      ''
      'while @i <= @MaxNumOfLanes'
      '    begin'
      
        '    INSERT INTO #Lanes(LaneID, LaneNum, LaneStr, HeatID) VALUES ' +
        '(@i, @i, CONCAT('#39'Lane '#39', @i), @HEATID); '
      '    SET @i = @i + 1;'
      '    end'
      ''
      'SELECT'
      '    #Lanes.LaneID'
      '    ,#Lanes.LaneNum'
      '    , Entrant.EntrantID'
      '    , Entrant.Lane'
      '    , HeatIndividual.HeatID'
      '    , HeatIndividual.HeatNum'
      '    , HeatIndividual.EventID'
      ',Entrant.MemberID'
      '    , CASE WHEN Entrant.EntrantID IS NULL'
      '        THEN CONCAT(FORMAT(#Lanes.LaneNum, '#39'00\.\ '#39'),'#39'EMPTY'#39')'
      '        ELSE CONCAT('
      #9#9#9'FORMAT(#Lanes.LaneNum, '#39'00\.\ '#39')'
      #9#9#9', Member.FirstName, '#39' '#39', UPPER(Member.LastName)'
      #9#9',CASE '
      #9#9'WHEN Entrant.IsDisqualified = 1 THEN '#39' (Disqualified)'#39
      #9#9'WHEN Entrant.IsScratched = 1 THEN '#39' (Scratched)'#39' '
      #9#9'ELSE '#39#39
      #9#9'END'#9#9#9
      #9#9#9')'
      '        END '
      #9#9
      #9#9'AS FName'
      '    FROM #Lanes'
      
        'LEFT OUTER JOIN  HeatIndividual on #Lanes.HeatID = HeatIndividua' +
        'l.HeatID'
      
        'Left outer join Entrant on HeatIndividual.HeatID = Entrant.HeatI' +
        'D and #Lanes.LaneNum = Entrant.Lane'
      'LEFT OUTER JOIN Member on Entrant.MemberID = Member.MemberID'
      'ORDER BY #Lanes.LaneNum;'
      ''
      ''
      ''
      'DROP TABLE [dbo].[#Lanes]'
      ';')
    Left = 40
    Top = 440
    ParamData = <
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1946
      end>
    object qryLaneLaneID: TIntegerField
      FieldName = 'LaneID'
      Origin = 'LaneID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLaneLaneNum: TIntegerField
      FieldName = 'LaneNum'
      Origin = 'LaneNum'
      Required = True
    end
    object qryLaneEntrantID: TFDAutoIncField
      FieldName = 'EntrantID'
      Origin = 'EntrantID'
    end
    object qryLaneLane: TIntegerField
      FieldName = 'Lane'
      Origin = 'Lane'
    end
    object qryLaneHeatID: TFDAutoIncField
      FieldName = 'HeatID'
      Origin = 'HeatID'
    end
    object qryLaneHeatNum: TIntegerField
      FieldName = 'HeatNum'
      Origin = 'HeatNum'
    end
    object qryLaneEventID: TIntegerField
      FieldName = 'EventID'
      Origin = 'EventID'
    end
    object qryLaneFName: TWideStringField
      FieldName = 'FName'
      Origin = 'FName'
      ReadOnly = True
      Required = True
      Size = 4000
    end
    object qryLaneMemberID: TIntegerField
      FieldName = 'MemberID'
      Origin = 'MemberID'
    end
  end
  object dsLane: TDataSource
    DataSet = qryLane
    Left = 112
    Top = 442
  end
  object qryQualifyState: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    IndexFieldNames = 'HeatID;EntrantID'
    Connection = scmConnection
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'USE [SwimClubMeet]'
      ';'
      ''
      'DECLARE @EntrantID as Integer;'
      'DECLARE @HeatID as Integer;'
      ''
      'SET @EntrantID = :ENTRANTID;'
      'SET @HeatID = :HEATID;'
      ''
      ''
      'SELECT [EntrantID]'
      '      ,[HeatID]'
      '      ,[IsDisqualified]'
      '      ,[IsScratched]'
      #9'  , case '
      #9#9'when [IsDisqualified] = 1 and [IsScratched] = 0 then 2'
      #9#9'when [IsDisqualified] = 0 and [IsScratched] = 1 then 3'
      #9#9'else 1'
      #9#9'end as QualifyState'
      ''
      '  FROM [dbo].[Entrant]'
      '  WHERE [EntrantID] = @EntrantID AND [HeatID] = @HeatID;'
      ''
      ';')
    Left = 248
    Top = 120
    ParamData = <
      item
        Name = 'ENTRANTID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'HEATID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryQualifyStateEntrantID: TFDAutoIncField
      FieldName = 'EntrantID'
      Origin = 'EntrantID'
    end
    object qryQualifyStateHeatID: TIntegerField
      FieldName = 'HeatID'
      Origin = 'HeatID'
    end
    object qryQualifyStateIsDisqualified: TBooleanField
      FieldName = 'IsDisqualified'
      Origin = 'IsDisqualified'
      Required = True
    end
    object qryQualifyStateIsScratched: TBooleanField
      FieldName = 'IsScratched'
      Origin = 'IsScratched'
      Required = True
    end
    object qryQualifyStateQualifyState: TIntegerField
      FieldName = 'QualifyState'
      Origin = 'QualifyState'
      ReadOnly = True
      Required = True
    end
  end
  object qrySCMSystem: TFDQuery
    ActiveStoredUsage = [auDesignTime]
    Connection = scmConnection
    SQL.Strings = (
      'USE SwimClubMeet;'
      ''
      'SELECT * FROM SCMSystem WHERE SCMSystemID = 1;')
    Left = 248
    Top = 264
    object qrySCMSystemSCMSystemID: TFDAutoIncField
      FieldName = 'SCMSystemID'
      Origin = 'SCMSystemID'
    end
    object qrySCMSystemDBVersion: TIntegerField
      FieldName = 'DBVersion'
      Origin = 'DBVersion'
    end
    object qrySCMSystemMajor: TIntegerField
      FieldName = 'Major'
      Origin = 'Major'
    end
    object qrySCMSystemMinor: TIntegerField
      FieldName = 'Minor'
      Origin = 'Minor'
    end
    object qrySCMSystemBuild: TIntegerField
      FieldName = 'Build'
      Origin = 'Build'
    end
  end
  object dsSCMSystem: TDataSource
    DataSet = qrySCMSystem
    Left = 312
    Top = 264
  end
end
