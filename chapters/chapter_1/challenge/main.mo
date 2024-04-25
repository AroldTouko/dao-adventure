import Buffer "mo:base/Buffer";
actor {

    var name = "Deviants DAO";
    var manifesto = "Une DAO pour les développeurs blockchains d'Afrique Francophone qui changent la donne";
    let goals = Buffer.Buffer<Text>(0);

    public shared query func getName() : async Text {
        return name;
    };

    public shared query func getManifesto() : async Text {
        return manifesto;
    };

    public func setManifesto(newManifesto : Text) : async () {
        manifesto:= newManifesto;
    };

    public func addGoal(newGoal : Text) : async () {
        goals.add(newGoal);
        return;
    };

    public shared query func getGoals() : async [Text] {
        return Buffer.toArray(goals);
    };
};