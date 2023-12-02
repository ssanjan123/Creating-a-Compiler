package semanticAnalyzer.types;

import java.util.List;
import java.util.Set;

public class TypeVariable implements Type{
    @Override
    public int getSize() {
        return 0;
    }

    @Override
    public String infoString() {
        return null;
    }

    private String name;
    Type constraint;
    List<TypeVariable> TypeVariables;




    public void setContraint(Type constraint) {
        this.constraint = constraint;
    }

    public TypeVariable(String name) {
        this.name = name;
        reset();
    }

    public void reset(){
        setContraint(PrimitiveType.NO_TYPE);
    }

    public boolean equivalent(Type otherType){
        if (constraint == PrimitiveType.NO_TYPE){
            setContraint(otherType);
            return true;
        }
        return constraint.equivalent(otherType);
    }


    public void resetTypeVariable(){
        for (TypeVariable typeVariable : TypeVariables){
            typeVariable.reset();
        }
    }

    public void addTypeVariables(Set<TypeVariable> TypeVariables){

    }

    public Type concreteType() {
        return constraint.concreteType();
    }

}
