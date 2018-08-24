public class Example5 {
    public static void func() {
        deleteDuplicateNameSObject('Contact');
        deleteDuplicateNameSObject('Lead');
    }

    public static void deleteDuplicateNameSObject(String sobjectName) {
        Set<String> uniqueName = new Set<String>();
        List<SObject> deleteList = new List<SObject>();
        List<SObject> listObjects = Database.query('SELECT Name, Id FROM ' + sobjectName + ' LIMIT 10000');
        for (SObject item : listObjects){
            if (uniqueName.contains((String)item.get('Name'))) {
                deleteList.add(item);
            }else {
                uniqueName.add((String)item.get('Name'));
            }
        }
        try {
            delete deleteList;
        } catch (DmlException e) {
            System.debug('DmlException :' + e.getMessage());
        }
    }
}