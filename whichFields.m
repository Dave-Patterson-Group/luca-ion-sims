function which = whichFields(fieldSet)
which = {};
fields = fieldnames(S);
for i = 1:length(fields)
    if strcmp(fields{i},'times') == 0
        thisChannel = fieldSet.(fields{i});
        if max(abs(thisChannel)) > 0
            which{end+1} = fields{i};
        end
    end
end
