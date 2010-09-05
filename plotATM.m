function plotATM(matName,infoName,signal)
%
% Version 1.0: Original form physioTools
% Version 1.1: plotATM.m modified to plot specific signals, 6th Sep 2010
%
% usage: plotATM('RECORDm.mat', 'RECORDm.info',[1 3 5])
% Plots only signal number 1, 3 and 5.
%
% This function reads a pair of files generated by 'wfdb2mat' from a
% PhysioBank record, baseline-corrects and scales the time series
% contained in the .mat file, and plots them.  The baseline-corrected
% and scaled time series are the rows of matrix 'val', and each
% column contains simultaneous samples of each time series.
%
% 'wfdb2mat' is part of the open-source WFDB Software Package available at
%    http://physionet.org/physiotools/wfdb.shtml
% If you have installed a working copy of 'wfdb2mat', run a shell command
% such as
%    wfdb2mat -r 100s -f 0 -t 10 >100sm.info
% to create a pair of files ('100sm.mat', '100sm.info') that can be read
% by this function.
%
% The files needed by this function can also be produced by the
% PhysioBank ATM, at
%    http://physionet.org/cgi-bin/ATM
%

% plotATM.m           O. Abdala			16 March 2009

  Octave = exist('OCTAVE_VERSION');
  load(matName);
  fid = fopen(infoName, 'rt');
  fgetl(fid);
  fgetl(fid);
  fgetl(fid);
  [freqint] = sscanf(fgetl(fid),'Sampling frequency: %f Hz  Sampling interval: %f sec');
  interval = freqint(2);
  fgetl(fid);
  signalIndex=1;
  if(Octave)
    for i=1:size(val,1)
      R=split(fgetl(fid),char(9));
      signalName{i} = R(2,:);
      gain(i) = str2num(R(3,:));
      base(i) = str2num(R(4,:));
      units{i} = R(5,:);
    end
  else
    for i=1:size(val,1)
      if (i==signal(signalIndex))
          [row(signalIndex), signalName(signalIndex), gain(signalIndex), base(signalIndex), units(signalIndex)]=strread(fgetl(fid),'%d%s%f%f%s','delimiter','\t');
          signalIndex = signalIndex+1;
      else
          % Dummy read to increment the file pointer.
          [row(signalIndex), signalName(signalIndex), gain(signalIndex), base(signalIndex), units(signalIndex)]=strread(fgetl(fid),'%d%s%f%f%s','delimiter','\t');
      end
      if (signalIndex > length(signal)) break; end;              
    end
  end
  fclose(fid);
  val(val==-32768) = NaN;
  signalIndex=1;
  valfiltered(signalIndex,:) = zeros(1,size(val,2));
  for i=1:size(val,1)
      if (i==signal(signalIndex))
            valfiltered(signalIndex,:) = (val(i,:)-base(signalIndex))/gain(signalIndex);
            signalIndex = signalIndex+1;
       end
       if (signalIndex > length(signal)), break; end;              
  end
  x = (1:size(val,2))*interval;
  valeinth = valfiltered(1,:)+valfiltered(3,:);
   plot(x',valfiltered'); 
  for i=1:length(signal)
            labels{i}=strcat(signalName{i},' (',units{i},')'); 
  end
  legend(labels);
  xlabel('Time (sec)');
end
