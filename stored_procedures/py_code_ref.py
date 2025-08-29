def memoize_dt(s):
    #https://towardsdatascience.com/speeding-through-dates-with-pandas-35472ba028f9
    #Memoization technique
    #dates = {date: dt.datetime.strptime(date,'%m/%d/%Y') for date in s.unique()}
    pt1 = pd.DataFrame(s.unique(), columns=['date'])
    pt1['datetime'] = (pt1['date'].fillna(np.datetime64('NaT')).array.astype('M8[ns]')
    pt1.index = pt1['date']
    return s.map(pt1['datetime'])

def strftime(s):
    return s.apply(lambda tm: '%d%02d%02d' % (tm.year, tm.month, tm.day))

def field_ref(xfile, keyw):
    fld = pd.read_excel(xfile, keyw, index_col='old')
    flds = fld[fld['new'].notna()]
    
    #typ = flds[flds['dtype'] != 'object']
    #dtyp = pd.Series(typ.dtype).to_dict()
    name = pd.Series(flds.new).to_dict()
    return name

def tar2zip(tfile):  #convert tar to zip file. INPUT: tar file address
    zfnam = f"{tfile[:-4]}_{dt.datetime.now().strftime('%m-%d-%y')}.zip"
    tarf = tarfile.open(tfile, mode='r|gz' )
    zipf = zp.ZipFile(zfnam, mode='w', compression=zp.ZIP_DEFLATED)

    for m in tarf:
        f = tarf.extractfile(m)
        fl = f.read()
        fn = m.name
        zipf.writestr( fn, fl )
    tarf.close()
    return zipf.close()

def df2zip(df, dr, fname):  #save pd df as zipfile. INPUT: df object, dir path, & saved file name
    compr_opt = dict(method='zip', archive_name=f'{fname}.csv')
    return df.to_csv(dr + f'{fname}.zip', index=False, compression=compr_opt)

def read_ziptxt(keynam, nvars):  #individually proccess a zipfile's item. INPUT: dir + file, 3 letter of subfile name
    dtzip = zp.ZipFile(loc.tz + zflis[0], mode='r')
    pref = 'memorialhermann_edw_covid19_datascience_covid_19_'
    ldt = read_dict(loc.cdt + keynam + '_dtypes.txt')
    ldtyp = {x:y for x,y in ldt.items() if x in nvars}
    
    dt_nam = [x for x in dtzip.namelist() if (pref + keynam) in x]
    df = pd.read_csv(dtzip.open(dt_nam[0]), usecols=nvars, header=0, engine='c', memory_map=True, dtype=ldtyp)
    dtzip.close()
    return df

def getdt(file):
    return dt.datetime.fromtimestamp(os.path.getmtime(file))

def col_index(df, keyword):  # Create multi-level column
    lis = []
    for x in range(len(df.columns)):  # Create repeating column name based on df column count for multi-level index column
        lis.append(keyword)
        
    dt = pd.MultiIndex.from_arrays([lis, df.columns])
    return dt

def row_index(df, keyword):  # Create multi-level column
    lis = []
    for x in range(len(df.index)):  # Create repeating column name based on df column count for multi-level index column
        lis.append(keyword)
        
    dt = pd.MultiIndex.from_arrays([lis, df.index])
    return dt