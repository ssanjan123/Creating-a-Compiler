package semanticAnalyzer.signatures;

import semanticAnalyzer.types.PrimitiveType;
import semanticAnalyzer.types.Type;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class PromotedSignature {
    FunctionSignature signature;
    List<Promotion> promotions;
    List<Type> typeVariableSettings;


    public PromotedSignature(FunctionSignature signature, List<Promotion> promotions) {
        this.signature = signature;
        this.promotions = new ArrayList<Promotion>(promotions);
        this.typeVariableSettings = signature.typeVariableSettings();

    }

    public Type resultType(){
        setTypeVariables();
        return signature.resultType().concreteType();
    }

    private void setTypeVariables(){
        signature.setTypeVariables(typeVariableSettings);//values
    }

    public boolean accepts(List<Type> childTypes){
        setTypeVariables();
        return signature.accepts(childTypes);
    }

    public Promotion promotion (int index){
        return promotions.get(index);
    }

    public Object getVariant(){
        return signature.getVariant();
    }










    public static List <PromotedSignature> promotedSignatures (FunctionSignatures signatures, List<Type> types){
        List <PromotedSignature> result = new ArrayList<PromotedSignature>();
        for (FunctionSignature signature : signatures){
            result.addAll(findAll(signature, types));
        }
        return result;

    }

    private static List <PromotedSignature> findAll (FunctionSignature signature, List<Type> types){
        List <PromotedSignature> promotedSignatures = new ArrayList<>();
        List<Promotion> promotions = new ArrayList<>();
        for (int i = 0; i < types.size(); i++){
            promotions.add(Promotion.NONE);
        }

        List <Type> promotedTypes = new ArrayList<Type>();
        for(Promotion promotion : promotions){///
            promotedTypes.add(PrimitiveType.NO_TYPE);
        }


        findAllRecursive(signature, types, promotions, promotedTypes, promotedSignatures, 0);
        return promotedSignatures;
    }

    //current type at index
    private static void findAllRecursive(FunctionSignature signature, List<Type> types, List<Promotion> promotions, List <Type> promotedTypes, List <PromotedSignature> promotedSignatures, int index){
        if(index >= types.size()){
            if (signature.accepts(promotedTypes)){
                promotedSignatures.add(new PromotedSignature(signature, promotions));
            }
            return;
        }
        Type type = types.get(index);
        for (Promotion promotion : Promotion.values()){
            if (promotion.appliesTo(type)){
                promotedTypes.set(index, promotion.apply(type));//
                promotions.set(index, promotion);//new line
                findAllRecursive(signature, types, promotions, promotedTypes, promotedSignatures, index + 1);
            }
            //findallrecursive used to bve here
        }
        return;
    }

    public int numPromotions(){
        int result = 0;
        for (Promotion promotion : promotions){
            if (!promotion.isNull()){
                result = result + 1;
            }
        }
        return result;
    }


    // Null object pattern
    private static PromotedSignature neverMatchedSignature = new PromotedSignature(FunctionSignature.nullInstance(), Arrays.asList(Promotion.NONE)) {
        public boolean accepts(List<Type> types) {
            return false;
        }
        public boolean isNull() {
            return true;
        }
    };
    public static PromotedSignature nullInstance() {
        return neverMatchedSignature;
    }


}
