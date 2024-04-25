import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Types "types";
actor {

    type Member = Types.Member;
    type HashMap<K, V> = Types.HashMap<K, V>;

    type Result<Ok, Err> = { #ok : Ok; #err : Err };

    let members = HashMap.HashMap<Principal, Member>(1, Principal.equal, Principal.hash);

    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {

        if (members.get(caller) == null) {
            members.put(caller, member);
            return #ok();
        };

        return #err("The member already exists");
    };

    public query func getMember(p : Principal) : async Result<Member, Text> {
        switch (members.get(p)) {
            case (null) {
                return #err("The member doesn't exists");
            };
            case (?member) {
                return #ok(member);
            };
        };
    };

    public shared ({ caller }) func updateMember(member : Member) : async Result<(), Text> {
        if (members.get(caller) == null) {
            return #err("The member doesn't exist");
        };

        members.put(caller, member);
        return #ok();
    };

    public query func getAllMembers() : async [Member] {
        return Iter.toArray(members.vals());
    };

    public query func numberOfMembers() : async Nat {
        return members.size();
    };

    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        if (members.get(caller) == null) {
            return #err("The member doesn't exists");
        };

        members.delete(caller);
        return #ok();

    };

};
