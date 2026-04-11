global class SettingsGetResponse {

    global String themeMainColor { get; private set; }
    global String themeSecondColor { get; private set; }
    global String themeBlueColor { get; private set; }
    global String themeGreyColor { get; private set; }
    global String themeLightColor { get; private set; }
    global String themeOppositeColor { get; private set; }
    global String themeGradient { get; private set; }
    global String themeAdditColor1 { get; private set; }
    global String themeAdditColor2 { get; private set; }
    global String themeAdditColor3 { get; private set; }
    global String themeAdditColor4 { get; private set; }
    global String themeAdditColor5 { get; private set; }
    global String themeAdditColor6 { get; private set; }
    global String themeAdditColor7 { get; private set; }

    global SettingsGetResponse(Settings__c settings) {
        this.themeMainColor = settings.ThemeMainColor__c;
        this.themeSecondColor = settings.ThemeSecondColor__c;
        this.themeBlueColor = settings.ThemeBlueColor__c;
        this.themeGreyColor = settings.ThemeGreyColor__c;
        this.themeLightColor = settings.ThemeLightColor__c;
        this.themeOppositeColor = settings.ThemeOppositeColor__c;
        this.themeGradient = settings.ThemeGradient__c;
        this.themeAdditColor1 = settings.ThemeAdditColor1__c;
        this.themeAdditColor2 = settings.ThemeAdditColor2__c;
        this.themeAdditColor3 = settings.ThemeAdditColor3__c;
        this.themeAdditColor4 = settings.ThemeAdditColor4__c;
        this.themeAdditColor5 = settings.ThemeAdditColor5__c;
        this.themeAdditColor6 = settings.ThemeAdditColor6__c;
        this.themeAdditColor7 = settings.ThemeAdditColor7__c;
    }
}
